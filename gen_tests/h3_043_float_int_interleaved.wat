;; Float and integer globals interleaved
(module
  (global $gf (export "gf") (mut f32) (f32.const 0.0))
  (global $gi (export "gi") (mut i32) (i32.const 0))
  (global $gd (export "gd") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const 3.14
    global.set $gf
    i32.const 3301
    global.set $gi
    f64.const 3.14159
    global.set $gd
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gf drop
    global.get $gi drop
    global.get $gd drop))
