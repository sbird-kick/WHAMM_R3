(module
  (import "s7_c06_host" "f0" (func $f0 (param f32) (param i32) (result f32)))
  (import "s7_c06_host" "f1" (func $f1 (param f64) (result f32)))
  (import "s7_c06_host" "f2" (func $f2 (param i64) (param f64) (result i32)))
  (func (export "_start")
    i64.const 212
    f64.const 79.0
    call $f2
    drop
    f32.const 105.0
    i32.const 290
    call $f0
    drop
    f64.const 208.0
    call $f1
    drop
  )
)
