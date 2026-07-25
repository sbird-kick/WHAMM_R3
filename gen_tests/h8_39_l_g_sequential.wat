;; h8_39_l_g_sequential: Sequential load then global read
(module
  (memory (export "memory") 1)
  (global $gk (export "gk") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 1024 i32.const 77 i32.store
    i32.const 888 global.set $gk
    call $app_check_both)
  (func $app_check_both (export "app_check_both")
    i32.const 1024 i32.load drop
    global.get $gk drop))
