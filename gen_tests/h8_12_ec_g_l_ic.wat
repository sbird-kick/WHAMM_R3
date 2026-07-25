;; h8_12_ec_g_l_ic: EC + G + L + IC
(module
  (memory (export "memory") 1)
  (global $g6 (export "g6") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 67 global.set $g6
    i32.const 256 i32.const 200 i32.store
    call $app_doit)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_doit (export "app_doit")
    global.get $g6 drop
    i32.const 256 i32.load drop
    call $r3_helper))
