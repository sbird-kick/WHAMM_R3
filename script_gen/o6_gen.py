#!/usr/bin/env python3
# Generate o6_ themed tests: stress whamm instrumentation semantics.
import os
OUT = "/Users/humza/Downloads/claude-play-space/WHAMM_R3/gen_tests"

tests = {}

# ---- Nested control flow with result values containing instrumented loads ----

tests["o6_02_loop_br_load"] = r'''
;; Loop with br carrying result, load each iter -> multiple L
(module
  (memory (export "memory") 1)
  (global $sum (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_loop drop)
  (func $r3_poke
    i32.const 160 i32.const 9606 i32.store
    i32.const 168 i32.const 606 i32.store)
  (func $app_loop (export "app_loop") (result i32)
    (local $i i32)
    (block $done (result i32)
      (loop $lp (result i32)
        i32.const 160 i32.load
        i32.const 168 i32.load i32.add
        local.get $i i32.const 1 i32.add local.tee $i
        i32.const 2 i32.lt_s
        br_if $lp
        br $done))))
'''

tests["o6_03_if_else_result"] = r'''
;; if/else both arms load, produce result value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 1 call $app_pick drop
    i32.const 0 call $app_pick drop)
  (func $r3_poke
    i32.const 240 i32.const 111 i32.store
    i32.const 248 i32.const 222 i32.store)
  (func $app_pick (export "app_pick") (param $c i32) (result i32)
    (if (result i32) (local.get $c)
      (then i32.const 240 i32.load)
      (else i32.const 248 i32.load))))
'''

tests["o6_04_nested_if_block"] = r'''
;; nested if inside block with result, load in innermost
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_nif drop)
  (func $r3_poke i32.const 320 i32.const 9999 i32.store)
  (func $app_nif (export "app_nif") (result i32)
    (block $b (result i32)
      (if (result i32) (i32.const 1)
        (then
          (if (result i32) (i32.const 1)
            (then i32.const 320 i32.load)
            (else i32.const 0)))
        (else i32.const 0)))))
'''

tests["o6_05_multivalue_block"] = r'''
;; multivalue block returns 2 values, both from loads
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mv drop)
  (func $r3_poke
    i32.const 400 i32.const 7 i32.store
    i32.const 408 i32.const 8 i32.store)
  (func $app_mv (export "app_mv") (result i32)
    (block $b (result i32 i32)
      i32.const 400 i32.load
      i32.const 408 i32.load)
    i32.add))
'''

tests["o6_06_multivalue_func"] = r'''
;; multivalue function returning 2 values (res0 = LAST result)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_pair
    i32.add drop)
  (func $r3_poke
    i32.const 480 i32.const 41 i32.store
    i32.const 488 i32.const 42 i32.store)
  (func $app_pair (export "app_pair") (result i32 i32)
    i32.const 480 i32.load
    i32.const 488 i32.load))
'''

tests["o6_07_mv_mixed_types"] = r'''
;; multivalue block (i32,i64) feeding ops
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mix drop)
  (func $r3_poke
    i32.const 560 i32.const 123 i32.store
    i32.const 568 i64.const 4567 i64.store)
  (func $app_mix (export "app_mix") (result i64)
    (block $b (result i32 i64)
      i32.const 560 i32.load
      i32.const 568 i64.load)
    (local.set 0)
    (i64.extend_i32_s)
    (local.get 0)
    i64.add
    (local i32) (local i64)))
'''

tests["o6_08_untyped_select_store"] = r'''
;; untyped select of two loaded values, store result, load back
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_sel)
  (func $r3_poke
    i32.const 640 i32.const 500 i32.store
    i32.const 648 i32.const 600 i32.store)
  (func $app_sel (export "app_sel")
    i32.const 656
    i32.const 640 i32.load
    i32.const 648 i32.load
    i32.const 1
    select
    i32.store
    i32.const 656 i32.load drop))
'''

tests["o6_09_typed_select_store"] = r'''
;; typed select feeding a store, operands loaded
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_tsel)
  (func $r3_poke
    i32.const 720 i64.const 88 i64.store
    i32.const 728 i64.const 99 i64.store)
  (func $app_tsel (export "app_tsel")
    i32.const 736
    i32.const 720 i64.load
    i32.const 728 i64.load
    i32.const 0
    (select (result i64))
    i64.store
    i32.const 736 i64.load drop))
'''

tests["o6_10_select_cond_global"] = r'''
;; select condition is a host-written global (G), operands loaded
(module
  (memory (export "memory") 1)
  (global $c (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_scg drop)
  (func $r3_poke
    i32.const 800 i32.const 1000 i32.store
    i32.const 808 i32.const 2000 i32.store
    i32.const 1 global.set $c)
  (func $app_scg (export "app_scg") (result i32)
    i32.const 800 i32.load
    i32.const 808 i32.load
    global.get $c
    select))
'''

tests["o6_11_br_table_loads"] = r'''
;; br_table with many targets, each block loads a different addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 0 call $app_bt drop
    i32.const 1 call $app_bt drop
    i32.const 2 call $app_bt drop
    i32.const 3 call $app_bt drop)
  (func $r3_poke
    i32.const 880 i32.const 10 i32.store
    i32.const 888 i32.const 20 i32.store
    i32.const 896 i32.const 30 i32.store
    i32.const 904 i32.const 40 i32.store)
  (func $app_bt (export "app_bt") (param $s i32) (result i32)
    (block $b3 (result i32)
      (block $b2 (result i32)
        (block $b1 (result i32)
          (block $b0 (result i32)
            (block $dispatch
              local.get $s
              br_table $b0 $b1 $b2 $b3 $dispatch)
            i32.const 880 i32.load return)
          i32.const 888 i32.load return)
        i32.const 896 i32.load return)
      i32.const 904 i32.load return)))
'''

tests["o6_12_tee_chain_global"] = r'''
;; local.tee chain feeding global.set; host wrote g_in, app reads (G)
(module
  (memory (export "memory") 1)
  (global $g_in (mut i32) (i32.const 0))
  (global $g_out (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 55 global.set $g_in
    call $app_tee)
  (func $app_tee (export "app_tee")
    (local $a i32) (local $b i32)
    global.get $g_in
    local.tee $a
    local.tee $b
    global.set $g_out))
'''

tests["o6_13_deep_loop_nest"] = r'''
;; two nested loops, inner loads, outer accumulates -> multiple L
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_dl drop)
  (func $r3_poke i32.const 960 i32.const 3 i32.store)
  (func $app_dl (export "app_dl") (result i32)
    (local $i i32) (local $j i32) (local $acc i32)
    (loop $outer
      i32.const 0 local.set $j
      (loop $inner
        i32.const 960 i32.load
        local.get $acc i32.add local.set $acc
        local.get $j i32.const 1 i32.add local.tee $j
        i32.const 2 i32.lt_s br_if $inner)
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 2 i32.lt_s br_if $outer)
    local.get $acc))
'''

tests["o6_14_ic_in_nested"] = r'''
;; app calls host r3 fn inside nested if -> IC/IR, plus load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_call)
  (func $r3_poke i32.const 1040 i32.const 77 i32.store)
  (func $r3_helper
    nop)
  (func $app_call (export "app_call")
    (if (i32.const 1)
      (then
        (block $b
          i32.const 1040 i32.load drop
          call $r3_helper)))))
'''

tests["o6_15_br_table_single_target"] = r'''
;; br_table where all entries point to same target, load after
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 5 call $app_bts drop)
  (func $r3_poke i32.const 1120 i32.const 321 i32.store)
  (func $app_bts (export "app_bts") (param $s i32) (result i32)
    (block $out (result i32)
      (block $t
        local.get $s
        br_table $t $t $t $out)
      i32.const 1120 i32.load return)
    ))
'''

tests["o6_16_mv_loop_carry"] = r'''
;; multivalue loop carrying two values, load feeds carry
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mvl drop)
  (func $r3_poke i32.const 1200 i32.const 4 i32.store)
  (func $app_mvl (export "app_mvl") (result i32)
    (local $n i32)
    i32.const 0   ;; acc
    i32.const 0   ;; i
    (loop $lp (param i32 i32) (result i32)
      local.set $n            ;; i
      ;; acc on stack
      i32.const 1200 i32.load i32.add
      local.get $n i32.const 1 i32.add
      local.tee $n
      i32.const 2 i32.lt_s
      (if (param i32 i32) (result i32) (i32.const 1)
        (then
          local.set $n
          local.get $n i32.const 2 i32.lt_s
          br_if $lp
          local.get $n drop)
        (else drop))
      )))
'''

tests["o6_17_select_operands_globals"] = r'''
;; select operands are two host-written globals -> two G, feed store
(module
  (memory (export "memory") 1)
  (global $ga (mut i32) (i32.const 0))
  (global $gb (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 12 global.set $ga
    i32.const 34 global.set $gb
    call $app_sog)
  (func $app_sog (export "app_sog")
    i32.const 1280
    global.get $ga
    global.get $gb
    i32.const 1
    select
    i32.store
    i32.const 1280 i32.load drop))
'''

tests["o6_18_load_in_block_param"] = r'''
;; block with params: value pushed then block consumes, load inside
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_bp drop)
  (func $r3_poke i32.const 1360 i32.const 6060 i32.store)
  (func $app_bp (export "app_bp") (result i32)
    i32.const 100
    (block $b (param i32) (result i32)
      i32.const 1360 i32.load
      i32.add)))
'''

tests["o6_19_multi_load_add_tree"] = r'''
;; several loads combined in expression tree inside nested blocks
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_tree drop)
  (func $r3_poke
    i32.const 1440 i32.const 1 i32.store
    i32.const 1448 i32.const 2 i32.store
    i32.const 1456 i32.const 3 i32.store
    i32.const 1464 i32.const 4 i32.store)
  (func $app_tree (export "app_tree") (result i32)
    (block $b (result i32)
      (i32.add
        (i32.add (i32.const 1440 i32.load) (i32.const 1448 i32.load))
        (i32.add (i32.const 1456 i32.load) (i32.const 1464 i32.load))))))
'''

tests["o6_20_f64_select_nan"] = r'''
;; f64 typed select with NaN literal constant operand, feed store
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_fsel)
  (func $r3_poke i32.const 1520 f64.const nan f64.store)
  (func $app_fsel (export "app_fsel")
    i32.const 1528
    i32.const 1520 f64.load
    f64.const 1.5
    i32.const 1
    (select (result f64))
    f64.store
    i32.const 1528 f64.load drop))
'''

# ---- write all ----
for name, body in tests.items():
    path = os.path.join(OUT, name + ".wat")
    with open(path, "w") as f:
        f.write(body.strip() + "\n")
    print("wrote", name)
print("total", len(tests))
