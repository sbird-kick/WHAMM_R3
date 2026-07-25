;; Complex matrix: 4 i32, 2 i64, 2 f32, 2 f64 with multiple mutations
(module
  (global $gi1 (export "gi1") (mut i32) (i32.const 0))
  (global $gi2 (export "gi2") (mut i32) (i32.const 0))
  (global $gi3 (export "gi3") (mut i32) (i32.const 0))
  (global $gi4 (export "gi4") (mut i32) (i32.const 0))
  (global $gl1 (export "gl1") (mut i64) (i64.const 0))
  (global $gl2 (export "gl2") (mut i64) (i64.const 0))
  (global $gf1 (export "gf1") (mut f32) (f32.const 0.0))
  (global $gf2 (export "gf2") (mut f32) (f32.const 0.0))
  (global $gd1 (export "gd1") (mut f64) (f64.const 0.0))
  (global $gd2 (export "gd2") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    i32.const 100
    global.set $gi1
    i32.const 200
    global.set $gi2
    i32.const 300
    global.set $gi3
    i32.const 400
    global.set $gi4
    i64.const 1000
    global.set $gl1
    i64.const 2000
    global.set $gl2
    f32.const 1.5
    global.set $gf1
    f32.const 2.5
    global.set $gf2
    f64.const 3.14
    global.set $gd1
    f64.const 2.71
    global.set $gd2
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gi1 drop
    global.get $gi2 drop
    global.get $gi3 drop
    global.get $gi4 drop
    global.get $gl1 drop
    global.get $gl2 drop
    global.get $gf1 drop
    global.get $gf2 drop
    global.get $gd1 drop
    global.get $gd2 drop))
