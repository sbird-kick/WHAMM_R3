;; h8_13_l_g_ic_ec: Everything from app perspective
(module
  (memory (export "memory") 1)
  (global $g7 (export "g7") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 99 global.set $g7
    i32.const 512 i32.const 77 i32.store
    call $app_full)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_full (export "app_full")
    i32.const 512 i32.load drop
    global.get $g7 drop
    call $r3_helper))
