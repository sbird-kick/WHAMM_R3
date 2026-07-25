;; h8_20_ec_ic_l_g: EC + IC + L + G
(module
  (memory (export "memory") 1)
  (global $gd (export "gd") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 71 global.set $gd
    i32.const 32 i32.const 88 i32.store
    call $app_core)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_core (export "app_core")
    call $r3_helper
    i32.const 32 i32.load drop
    global.get $gd drop))
