;; Four globals, one of each type
(module
  (global $gi (export "gi") (mut i32) (i32.const 0))
  (global $gl (export "gl") (mut i64) (i64.const 0))
  (global $gf (export "gf") (mut f32) (f32.const 0.0))
  (global $gd (export "gd") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $gi
    i64.const 3302
    global.set $gl
    f32.const 33.0
    global.set $gf
    f64.const 330.0
    global.set $gd
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gi drop
    global.get $gl drop
    global.get $gf drop
    global.get $gd drop))
