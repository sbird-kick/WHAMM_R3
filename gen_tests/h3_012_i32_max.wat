;; i32 global set to max value
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 2147483647
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
