;; f32 and f64 with small fractional values
(module
  (global $gf (export "gf") (mut f32) (f32.const 0.0))
  (global $gd (export "gd") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const 0.001
    global.set $gf
    f64.const 0.00001
    global.set $gd
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gf drop
    global.get $gd drop))
