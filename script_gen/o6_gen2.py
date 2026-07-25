#!/usr/bin/env python3
import os
OUT = "/Users/humza/Downloads/claude-play-space/WHAMM_R3/gen_tests"
tests = {}

tests["o6_21_deep10_block_load"] = r'''
;; single load buried 10 blocks deep, each producing a result
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_d10 drop)
  (func $r3_poke i32.const 2000 i32.const 96060 i32.store)
  (func $app_d10 (export "app_d10") (result i32)
    (block (result i32)(block (result i32)(block (result i32)(block (result i32)
    (block (result i32)(block (result i32)(block (result i32)(block (result i32)
    (block (result i32)(block (result i32)
      i32.const 2000 i32.load
    ))))))))))))
'''

tests["o6_22_load_in_loop_with_ic"] = r'''
;; loop interleaving a load (L) and a host call (IC/IR) each iteration
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_li)
  (func $r3_poke i32.const 2080 i32.const 5 i32.store)
  (func $r3_tick nop)
  (func $app_li (export "app_li")
    (local $i i32)
    (loop $lp
      i32.const 2080 i32.load drop
      call $r3_tick
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 3 i32.lt_s br_if $lp)))
'''

tests["o6_23_call_indirect_host"] = r'''
;; call_indirect into host r3 fn (IC/IR) from inside nested if
(module
  (memory (export "memory") 1)
  (table 2 funcref)
  (elem (i32.const 0) $r3_target $app_other)
  (type $v (func))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_ci)
  (func $r3_poke i32.const 2160 i32.const 7 i32.store)
  (func $r3_target (type $v) nop)
  (func $app_other (type $v) nop)
  (func $app_ci (export "app_ci")
    (block $b
      i32.const 2160 i32.load drop
      (if (i32.const 1)
        (then i32.const 0 call_indirect (type $v))))))
'''

tests["o6_24_memgrow_nested"] = r'''
;; memory.grow (MG) inside nested block, then load from new page
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_grow drop)
  (func $r3_poke i32.const 100 i32.const 4242 i32.store)
  (func $app_grow (export "app_grow") (result i32)
    (block $b (result i32)
      i32.const 1 memory.grow drop
      i32.const 100 i32.load)))
'''

tests["o6_25_select_into_store_typed_f32"] = r'''
;; f32 typed select of loaded vs const, stored then loaded back
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_f32)
  (func $r3_poke i32.const 2240 f32.const 3.5 f32.store)
  (func $app_f32 (export "app_f32")
    i32.const 2248
    i32.const 2240 f32.load
    f32.const 1.25
    i32.const 0
    (select (result f32))
    f32.store
    i32.const 2248 f32.load drop))
'''

tests["o6_26_br_table_20"] = r'''
;; br_table with 20 targets each loading a distinct addr (bulk)
'''

tests["o6_27_mv_func_three"] = r'''
;; function returning THREE values from three loads (res0=LAST)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_three i32.add i32.add drop)
  (func $r3_poke
    i32.const 3200 i32.const 100 i32.store
    i32.const 3208 i32.const 200 i32.store
    i32.const 3216 i32.const 300 i32.store)
  (func $app_three (export "app_three") (result i32 i32 i32)
    i32.const 3200 i32.load
    i32.const 3208 i32.load
    i32.const 3216 i32.load))
'''

tests["o6_28_tee_addr_then_load"] = r'''
;; local.tee produces the ADDRESS used by a subsequent load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_ta drop)
  (func $r3_poke i32.const 3280 i32.const 8181 i32.store)
  (func $app_ta (export "app_ta") (result i32)
    (local $p i32)
    i32.const 3280 local.tee $p
    drop
    local.get $p i32.load))
'''

tests["o6_29_br_to_outer_from_if"] = r'''
;; br to outer block label from inside if, carrying loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_bo drop)
  (func $r3_poke i32.const 3360 i32.const 909 i32.store)
  (func $app_bo (export "app_bo") (result i32)
    (block $out (result i32)
      (block $in
        (if (i32.const 1)
          (then i32.const 3360 i32.load br $out)))
      i32.const 0)))
'''

tests["o6_30_select_mv_block_operands"] = r'''
;; multivalue block yields two loads which become select operands
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_smv drop)
  (func $r3_poke
    i32.const 3440 i32.const 71 i32.store
    i32.const 3448 i32.const 72 i32.store)
  (func $app_smv (export "app_smv") (result i32)
    (block $b (result i32 i32)
      i32.const 3440 i32.load
      i32.const 3448 i32.load)
    i32.const 1
    select))
'''

tests["o6_31_global_in_br_table"] = r'''
;; br_table selector from host global (G), targets load
(module
  (memory (export "memory") 1)
  (global $sel (export "sel") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 1 global.set $sel
    call $app_gbt drop)
  (func $r3_poke
    i32.const 3520 i32.const 11 i32.store
    i32.const 3528 i32.const 22 i32.store)
  (func $app_gbt (export "app_gbt") (result i32)
    (block $b1
      (block $b0
        global.get $sel
        br_table $b0 $b1 $b0)
      i32.const 3520 i32.load return)
    i32.const 3528 i32.load))
'''

tests["o6_32_i64_select_store"] = r'''
;; untyped select on i64 loads feeding an i64 store
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_i64s)
  (func $r3_poke
    i32.const 3600 i64.const 123456789 i64.store
    i32.const 3608 i64.const 987654321 i64.store)
  (func $app_i64s (export "app_i64s")
    i32.const 3616
    i32.const 3600 i64.load
    i32.const 3608 i64.load
    i32.const 1
    select
    i64.store
    i32.const 3616 i64.load drop))
'''

tests["o6_33_nested_loop_break_load"] = r'''
;; inner loop breaks to labelled outer block after loading
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_nlb drop)
  (func $r3_poke i32.const 3680 i32.const 4040 i32.store)
  (func $app_nlb (export "app_nlb") (result i32)
    (block $done (result i32)
      (loop $o
        (loop $i
          i32.const 3680 i32.load
          br $done)))))
'''

tests["o6_34_tee_chain_to_two_globals"] = r'''
;; read host global (G) then tee-chain into two app globals
(module
  (memory (export "memory") 1)
  (global $src (export "src") (mut i64) (i64.const 0))
  (global $a (mut i64) (i64.const 0))
  (global $b (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 7777 global.set $src
    call $app_tc)
  (func $app_tc (export "app_tc")
    (local $t i64)
    global.get $src
    local.tee $t
    global.set $a
    local.get $t
    global.set $b))
'''

tests["o6_35_if_else_globals"] = r'''
;; if/else arms each read a distinct host global (G), result stored
(module
  (memory (export "memory") 1)
  (global $ga (export "ga") (mut i32) (i32.const 0))
  (global $gb (export "gb") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 501 global.set $ga
    i32.const 502 global.set $gb
    i32.const 1 call $app_ig drop
    i32.const 0 call $app_ig drop)
  (func $app_ig (export "app_ig") (param $c i32) (result i32)
    (if (result i32) (local.get $c)
      (then global.get $ga)
      (else global.get $gb))))
'''

tests["o6_36_select_addr_load"] = r'''
;; select chooses the load ADDRESS between two host-written cells
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_sa drop)
  (func $r3_poke
    i32.const 3840 i32.const 6001 i32.store
    i32.const 3848 i32.const 6002 i32.store)
  (func $app_sa (export "app_sa") (result i32)
    i32.const 3840
    i32.const 3848
    i32.const 0
    select
    i32.load))
'''

tests["o6_37_grow_at_ir_boundary"] = r'''
;; memory.grow inside an app fn called by host, load old + new page
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_g2 drop)
  (func $r3_poke
    i32.const 200 i32.const 31 i32.store
    i32.const 208 i32.const 32 i32.store)
  (func $app_g2 (export "app_g2") (result i32)
    i32.const 200 i32.load
    (block $b
      i32.const 2 memory.grow drop)
    i32.const 208 i32.load
    i32.add))
'''

tests["o6_38_deep_if_chain_load"] = r'''
;; chain of nested if(result) each passing through the loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_dic drop)
  (func $r3_poke i32.const 4000 i32.const 12321 i32.store)
  (func $app_dic (export "app_dic") (result i32)
    (if (result i32) (i32.const 1)
      (then (if (result i32) (i32.const 1)
        (then (if (result i32) (i32.const 1)
          (then i32.const 4000 i32.load)
          (else i32.const 0)))
        (else i32.const 0)))
      (else i32.const 0))))
'''

tests["o6_39_br_if_carry_load"] = r'''
;; br_if inside block(result) conditionally carries a loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_bic drop)
  (func $r3_poke i32.const 4080 i32.const 55055 i32.store)
  (func $app_bic (export "app_bic") (result i32)
    (block $b (result i32)
      i32.const 4080 i32.load
      i32.const 1
      br_if $b
      drop
      i32.const 0)))
'''

tests["o6_40_select_untyped_globals_i64"] = r'''
;; untyped select of two host i64 globals (two G), result dropped
(module
  (memory (export "memory") 1)
  (global $x (export "x") (mut i64) (i64.const 0))
  (global $y (export "y") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 64064 global.set $x
    i64.const 46046 global.set $y
    call $app_sug drop)
  (func $app_sug (export "app_sug") (result i64)
    global.get $x
    global.get $y
    i32.const 1
    select))
'''

# programmatic big br_table
base = 4200
labels = " ".join(f"$b{i}" for i in range(20)) + " $b0"
poke = "\n    ".join(f"i32.const {base+i*8} i32.const {1000+i} i32.store" for i in range(20))
# build nested blocks: outermost $b19 ... innermost dispatch
inner = "        local.get $s\n        br_table " + labels
body = inner
for i in range(20):
    # after block i closes, load addr i and return
    body = f"(block $b{i}\n{body})\n      i32.const {base+i*8} i32.load return"
# The construction above is awkward; build explicitly instead:
lines = []
for i in range(20):
    lines.append("      " + "(block $b%d" % i)
lines.append("        local.get $s")
lines.append("        br_table " + labels)
for i in range(20):
    lines.append("      )")  # close block b i (from innermost b19 outward? need order)
# Simpler: emit structured text manually
bt = []
bt.append("(module")
bt.append('  (memory (export "memory") 1)')
bt.append('  (func $r3_main (export "_start") (export "main")')
bt.append("    call $r3_poke")
for i in range(20):
    bt.append(f"    i32.const {i} call $app_b20 drop")
bt.append("    )")
bt.append("  (func $r3_poke")
for i in range(20):
    bt.append(f"    i32.const {base+i*8} i32.const {1000+i} i32.store")
bt.append("    )")
bt.append('  (func $app_b20 (export "app_b20") (param $s i32) (result i32)')
# open 20 nested blocks b19(outer) .. b0(inner)
for i in range(19, -1, -1):
    bt.append("    (block $b%d" % i)
bt.append("      local.get $s")
bt.append("      br_table " + labels)
# closing: innermost open is b0, so first close corresponds to b0; after closing b0 we load addr0
for i in range(0, 20):
    bt.append(f"    i32.const {base+i*8} i32.load return)")
bt.append("    unreachable))")  # after all closes; should be unreachable (all paths return)
tests["o6_26_br_table_20"] = "\n".join(bt)

for name, body in tests.items():
    with open(os.path.join(OUT, name + ".wat"), "w") as f:
        f.write(body.strip() + "\n")
    print("wrote", name)
print("total", len(tests))
