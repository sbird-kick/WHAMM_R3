#!/usr/bin/env python3
# Generator for o5_ scale/structure tests. Seed 9505.
import os
SEED = 9505
OUT = os.path.join(os.path.dirname(__file__), "gen_tests")

def w(name, body):
    with open(os.path.join(OUT, name + ".wat"), "w") as f:
        f.write(body)

# ---------- Family A: massive function count (EC + L scale) ----------
def manyfn(name, n, do_load=True):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    # r3_main calls host poke then all app funcs
    main = ["  (func $r3_main (export \"_start\") (export \"main\")"]
    main.append("    call $r3_poke")
    for i in range(n):
        main.append(f"    call $app_{i}")
    main.append("  )")
    lines += main
    # host poke writes a spread of addresses
    poke = ["  (func $r3_poke"]
    for i in range(n):
        addr = 8 + (i * 4) % 60000
        val = (i * 7 + SEED) & 0x7fffffff
        poke.append(f"    i32.const {addr} i32.const {val} i32.store")
    poke.append("  )")
    lines += poke
    for i in range(n):
        addr = 8 + (i * 4) % 60000
        if do_load:
            lines.append(f"  (func $app_{i} (export \"app_{i}\") i32.const {addr} i32.load drop)")
        else:
            lines.append(f"  (func $app_{i} (export \"app_{i}\") nop)")
    lines.append(")")
    w(name, "\n".join(lines))

manyfn("o5_manyfn_200_load", 200, True)
manyfn("o5_manyfn_305_load", 305, True)
manyfn("o5_manyfn_250_noop", 250, False)
manyfn("o5_manyfn_512_load", 512, True)

# ---------- Family B: long app->app call chain (deep, one EC) ----------
def chain(name, n):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_0)")
    lines.append("  (func $r3_poke i32.const 16 i32.const %d i32.store)" % (SEED & 0x7fffffff))
    for i in range(n):
        if i < n - 1:
            lines.append(f"  (func $app_{i} (export \"app_{i}\") call $app_{i+1})")
        else:
            lines.append(f"  (func $app_{i} (export \"app_{i}\") i32.const 16 i32.load drop)")
    lines.append(")")
    w(name, "\n".join(lines))

chain("o5_chain_500", 500)
chain("o5_chain_900", 900)

# ---------- Family C: huge elem table + call_indirect across app funcs ----------
def indirect_app(name, n):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    lines.append(f"  (table {n} funcref)")
    lines.append("  (type $v (func))")
    # elem
    elems = " ".join(f"$t_{i}" for i in range(n))
    lines.append(f"  (elem (i32.const 0) {elems})")
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $driver)")
    lines.append("  (func $r3_poke i32.const 24 i32.const %d i32.store)" % ((SEED*3) & 0x7fffffff))
    drv = ["  (func $driver (export \"driver\")"]
    for i in range(n):
        drv.append(f"    i32.const {i} call_indirect (type $v)")
    drv.append("  )")
    lines += drv
    for i in range(n):
        lines.append(f"  (func $t_{i} (type $v) i32.const 24 i32.load drop)")
    lines.append(")")
    w(name, "\n".join(lines))

indirect_app("o5_indirect_app_200", 200)
indirect_app("o5_indirect_app_400", 400)

# ---------- Family C2: call_indirect into host (r3*) funcs -> IC/IR ----------
def indirect_host(name, n):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    lines.append(f"  (table {n} funcref)")
    lines.append("  (type $v (func))")
    elems = " ".join(f"$r3_h_{i}" for i in range(n))
    lines.append(f"  (elem (i32.const 0) {elems})")
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $driver)")
    drv = ["  (func $driver (export \"driver\")"]
    for i in range(n):
        drv.append(f"    i32.const {i} call_indirect (type $v)")
    drv.append("  )")
    lines += drv
    for i in range(n):
        lines.append(f"  (func $r3_h_{i} (type $v) nop)")
    lines.append(")")
    w(name, "\n".join(lines))

indirect_host("o5_indirect_host_150", 150)
indirect_host("o5_indirect_host_300", 300)

# ---------- Family D: 3+ memories ----------
def multimem(name, nmem):
    lines = ["(module"]
    for m in range(nmem):
        exp = ' (export "memory")' if m == 0 else ''
        lines.append(f"  (memory{exp} 1)")
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_read)")
    poke = ["  (func $r3_poke"]
    for m in range(nmem):
        addr = 8 + m*4
        val = (SEED + m*11) & 0x7fffffff
        poke.append(f"    i32.const {addr} i32.const {val} i32.store {m}")
    poke.append("  )")
    lines += poke
    rd = ["  (func $app_read (export \"app_read\")"]
    for m in range(nmem):
        addr = 8 + m*4
        rd.append(f"    i32.const {addr} i32.load {m} drop")
    rd.append("  )")
    lines += rd
    lines.append(")")
    w(name, "\n".join(lines))

multimem("o5_mem3", 3)
multimem("o5_mem4", 4)
multimem("o5_mem6", 6)

# ---------- Family E: dozens of data segments ----------
def data_many(name, nseg):
    lines = ["(module", "  (memory (export \"memory\") 2)"]
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_read)")
    # data segments
    for s in range(nseg):
        off = s * 16
        byte = (SEED + s) & 0xff
        lines.append(f"  (data (i32.const {off}) \"\\{byte:02x}\\{(byte+1)&0xff:02x}\\{(byte+2)&0xff:02x}\\{(byte+3)&0xff:02x}\")")
    # host writes one addr in the data region -> L when app loads
    tgt = 4
    lines.append("  (func $r3_poke i32.const %d i32.const %d i32.store)" % (tgt, (SEED*5)&0x7fffffff))
    rd = ["  (func $app_read (export \"app_read\")"]
    rd.append(f"    i32.const {tgt} i32.load drop")
    # also load some data-seeded (no L) addresses
    for s in range(0, nseg, 5):
        rd.append(f"    i32.const {s*16} i32.load drop")
    rd.append("  )")
    lines += rd
    lines.append(")")
    w(name, "\n".join(lines))

data_many("o5_data_40seg", 40)
data_many("o5_data_100seg", 100)

# ---------- Family F: huge locals + long param lists ----------
def locals_many(name, nloc):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_work)")
    lines.append("  (func $r3_poke i32.const 32 i32.const %d i32.store)" % (SEED&0x7fffffff))
    body = ["  (func $app_work (export \"app_work\")"]
    body.append("    (local " + " ".join("i32" for _ in range(nloc)) + ")")
    for i in range(nloc):
        body.append(f"    i32.const {i} local.set {i}")
    # sum a few, then load
    body.append("    i32.const 32 i32.load drop")
    body.append("  )")
    lines += body
    lines.append(")")
    w(name, "\n".join(lines))

locals_many("o5_locals_200", 200)
locals_many("o5_locals_400", 400)

def params_long(name, nparam):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    # r3_main calls app_f with nparam consts -> EC with long param list
    call = ["  (func $r3_main (export \"_start\") (export \"main\")"]
    for i in range(nparam):
        call.append(f"    i32.const {(i*13+SEED)&0x7fffffff}")
    call.append("    call $app_f)")
    lines += call
    ptypes = " ".join("i32" for _ in range(nparam))
    lines.append(f"  (func $app_f (export \"app_f\") (param {ptypes}) i32.const 40 i32.load drop)")
    lines.append(")")
    w(name, "\n".join(lines))

params_long("o5_params_60", 60)
params_long("o5_params_120", 120)

# mixed param types long
def params_mixed(name, nparam):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    call = ["  (func $r3_main (export \"_start\") (export \"main\")"]
    ptypes = []
    for i in range(nparam):
        t = ["i32","i64","f32","f64"][i % 4]
        ptypes.append(t)
        if t == "i32":
            call.append(f"    i32.const {(i+SEED)&0x7fffffff}")
        elif t == "i64":
            call.append(f"    i64.const {(i+SEED)}")
        elif t == "f32":
            call.append(f"    f32.const {i}.5")
        else:
            call.append(f"    f64.const {i}.25")
    call.append("    call $app_f)")
    lines += call
    lines.append(f"  (func $app_f (export \"app_f\") (param {' '.join(ptypes)}) i32.const 48 i32.load drop)")
    lines.append(")")
    w(name, "\n".join(lines))

params_mixed("o5_params_mixed_80", 80)

# ---------- Family G: many mutable globals -> G scale ----------
def globals_many(name, ng):
    lines = ["(module", "  (memory (export \"memory\") 1)"]
    for i in range(ng):
        lines.append(f"  (global $g{i} (export \"g{i}\") (mut i32) (i32.const {i}))")
    lines.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_set call $app_read)")
    st = ["  (func $r3_set"]
    for i in range(ng):
        st.append(f"    i32.const {(i*3+SEED)&0x7fffffff} global.set {i}")
    st.append("  )")
    lines += st
    rd = ["  (func $app_read (export \"app_read\")"]
    for i in range(ng):
        rd.append(f"    global.get {i} drop")
    rd.append("  )")
    lines += rd
    lines.append(")")
    w(name, "\n".join(lines))

globals_many("o5_globals_100", 100)
globals_many("o5_globals_250", 250)

print("generated")
