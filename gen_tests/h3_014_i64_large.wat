;; i64 global with large value
(module
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 9223372036854775807
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
