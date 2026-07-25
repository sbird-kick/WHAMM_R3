;; h8_18_ic_g_l: IC + G + L
(module
  (memory (export "memory") 1)
  (global $gb (export "gb") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 111 global.set $gb
    i32.const 8192 i32.const 222 i32.store
    call $app_access)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_access (export "app_access")
    global.get $gb drop
    call $r3_helper
    i32.const 8192 i32.load drop))
