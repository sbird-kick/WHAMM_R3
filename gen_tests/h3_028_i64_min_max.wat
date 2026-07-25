;; i64 global set to min and max values
(module
  (global $gmin (export "gmin") (mut i64) (i64.const 0))
  (global $gmax (export "gmax") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const -9223372036854775808
    global.set $gmin
    i64.const 9223372036854775807
    global.set $gmax
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gmin drop
    global.get $gmax drop))
