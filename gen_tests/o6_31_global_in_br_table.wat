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
