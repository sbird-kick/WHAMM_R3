;; Complex: multiple types, mixed divergences, multiple reads
(module
  (memory (export "mem") 1)
  (global $i32g (export "i32g") (mut i32) (i32.const 0))
  (global $i64g (export "i64g") (mut i64) (i64.const 0))
  (global $f32g (export "f32g") (mut f32) (f32.const 0.0))
  (global $f64g (export "f64g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start")
    i32.const 123
    global.set $i32g
    f32.const 4.5
    global.set $f32g
    call $work)
  (func $work (export "work")
    global.get $i32g
    drop
    global.get $i64g
    drop
    global.get $f32g
    drop
    global.get $f64g
    drop
    global.get $i32g
    drop))
