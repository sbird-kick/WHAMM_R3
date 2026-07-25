#!/usr/bin/env python3
import random, os
SEED = 9404
random.seed(SEED)
OUT = "/Users/humza/Downloads/claude-play-space/WHAMM_R3/gen_tests"
PFX = "o4_"

def addr():
    # 4-byte aligned-ish address well within one 64KiB page
    return random.randint(2, 14000) * 4

def val():
    return random.randint(1, 0x7fffffff)

def bval():
    return random.randint(1, 255)

tests = {}

def emit(name, body_funcs, main_calls):
    lines = ['(module', '  (memory (export "memory") 1)']
    lines.append('  (func $r3_main (export "_start") (export "main")')
    for c in main_calls:
        lines.append('    call $' + c)
    lines.append('  )')
    lines.extend(body_funcs)
    lines.append(')')
    tests[name] = "\n".join(lines) + "\n"

# ---- Family A: host writes SAME value shadow already holds (init 0) -> no L ----
for i in range(6):
    a = addr()
    if i % 2 == 0:
        poke = f'    i32.const {a} i32.const 0 i32.store'
    else:
        ln = random.randint(1, 8)
        poke = f'    i32.const {a} i32.const 0 i32.const {ln} memory.fill'
    fns = [
        f'  (func $r3_zero_{i}\n{poke})',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}A_hostzero_{i:02d}', fns, [f'r3_zero_{i}', f'app_rd_{i}'])

# ---- Family B: app writes V, host writes SAME V -> app load -> no L ----
for i in range(8):
    a = addr(); v = val()
    fns = [
        f'  (func $app_pre_{i} (export "app_pre_{i}")\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $r3_same_{i}\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}B_samevalue_{i:02d}', fns,
         [f'app_pre_{i}', f'r3_same_{i}', f'app_rd_{i}'])

# ---- Family C: app writes V, host writes DIFFERENT W -> app load -> L ----
for i in range(8):
    a = addr(); v = val(); w = val()
    if w == v: w ^= 1
    fns = [
        f'  (func $app_pre_{i} (export "app_pre_{i}")\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $r3_diff_{i}\n    i32.const {a} i32.const {w} i32.store)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}C_diffvalue_{i:02d}', fns,
         [f'app_pre_{i}', f'r3_diff_{i}', f'app_rd_{i}'])

# ---- Family D: off-by-one overlapping host writes, only one byte diverges ----
for i in range(6):
    a = addr()
    b = bval()
    # host store8 of b at a+1 only (single nonzero byte; rest of the i32 window is 0)
    fns = [
        f'  (func $r3_ov_{i}\n'
        f'    i32.const {a} i32.const 0 i32.store            ;; shadow stays 0, no change\n'
        f'    i32.const {a+1} i32.const {b} i32.store8)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}D_onebyte_{i:02d}', fns, [f'r3_ov_{i}', f'app_rd_{i}'])

# ---- Family E: single host write, repeated loads -> exactly one L ----
for i in range(6):
    a = addr(); v = val(); n = random.randint(2, 5)
    loads = "\n".join([f'    i32.const {a} i32.load drop' for _ in range(n)])
    fns = [
        f'  (func $r3_w_{i}\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n{loads})',
    ]
    emit(f'{PFX}E_repeat_{i:02d}', fns, [f'r3_w_{i}', f'app_rd_{i}'])

# ---- Family F: host write, app overwrites (shadow updated), load -> no L ----
for i in range(6):
    a = addr(); w = val(); u = val()
    fns = [
        f'  (func $r3_w_{i}\n    i32.const {a} i32.const {w} i32.store)',
        f'  (func $app_fix_{i} (export "app_fix_{i}")\n'
        f'    i32.const {a} i32.const {u} i32.store\n'
        f'    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}F_appfix_{i:02d}', fns, [f'r3_w_{i}', f'app_fix_{i}'])

# ---- Family G: interleaved EC boundaries, mix of L and no-L ----
for i in range(6):
    a1 = addr(); a2 = addr(); v = val()
    fns = [
        f'  (func $r3_w_{i}\n    i32.const {a1} i32.const {v} i32.store)',
        f'  (func $app_a_{i} (export "app_a_{i}")\n    i32.const {a1} i32.load drop)',
        f'  (func $app_b_{i} (export "app_b_{i}")\n    i32.const {a2} i32.load drop)',
    ]
    # order: read clean a2 (no L), host write a1, read a1 (L), read a2 (still clean)
    emit(f'{PFX}G_interleave_{i:02d}', fns,
         [f'app_b_{i}', f'r3_w_{i}', f'app_a_{i}', f'app_b_{i}'])

# ---- Family H: IC/IR boundaries: app calls host mid-stream ----
for i in range(6):
    a = addr(); v = val()
    fns = [
        f'  (func $r3_h_{i}\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $app_drv_{i} (export "app_drv_{i}")\n'
        f'    i32.const {a} i32.load drop\n'
        f'    call $r3_h_{i}\n'
        f'    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}H_icboundary_{i:02d}', fns, [f'app_drv_{i}'])

# ---- Family I: host writes same nonzero value twice (idempotent), no divergence beyond one L ----
for i in range(4):
    a = addr(); v = val()
    fns = [
        f'  (func $r3_w1_{i}\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $r3_w2_{i}\n    i32.const {a} i32.const {v} i32.store)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load drop)',
    ]
    emit(f'{PFX}I_hosttwice_{i:02d}', fns,
         [f'r3_w1_{i}', f'r3_w2_{i}', f'app_rd_{i}'])

# ---- Family J: partial-width: host store8 diverges only low byte; app load8 ----
for i in range(4):
    a = addr(); b = bval()
    fns = [
        f'  (func $r3_b_{i}\n    i32.const {a} i32.const {b} i32.store8)',
        f'  (func $app_rd_{i} (export "app_rd_{i}")\n    i32.const {a} i32.load8_u drop)',
    ]
    emit(f'{PFX}J_byte_{i:02d}', fns, [f'r3_b_{i}', f'app_rd_{i}'])

for name, src in tests.items():
    with open(os.path.join(OUT, name + ".wat"), "w") as f:
        f.write(src)
print(f"wrote {len(tests)} tests")
