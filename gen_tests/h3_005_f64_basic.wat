;; f64 global, host mutates, app reads
(module
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const 3301.0
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
