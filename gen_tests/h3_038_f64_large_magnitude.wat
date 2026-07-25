;; f64 with large magnitude values
(module
  (global $g1 (export "g1") (mut f64) (f64.const 0.0))
  (global $g2 (export "g2") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const 1.0e300
    global.set $g1
    f64.const -1.0e300
    global.set $g2
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g1 drop
    global.get $g2 drop))
