;; h8_07_ec_l_g_ic: EC + L + G + IC all in sequence
(module
  (memory (export "memory") 1)
  (global $g4 (export "g4") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 64 i32.const 77 i32.store
    i32.const 15 global.set $g4
    call $app_work)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_work (export "app_work")
    i32.const 64 i32.load drop
    global.get $g4 drop
    call $r3_helper))
