;; h8_08_l_g_ec: Memory and global changed, then called
(module
  (memory (export "memory") 1)
  (global $g5 (export "g5") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 80 i32.const 99 i32.store
    i32.const 50 global.set $g5
    call $app_check)
  (func $app_check (export "app_check")
    global.get $g5 drop
    i32.const 80 i32.load drop))
