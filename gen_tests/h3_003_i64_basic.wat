;; i64 global, host mutates, app reads
(module
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 330100
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
