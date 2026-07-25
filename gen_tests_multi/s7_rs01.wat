(module
  (import "s7_rs01_host" "f0" (func $f0 (param f64) (result i64)))
  (import "s7_rs01_host" "f1" (func $f1 (param f32) (result i32)))
  (import "s7_rs01_host" "f2" (func $f2 (param f64) (result f64)))
  (import "s7_rs01_host" "f3" (func $f3 (param i32) (param f64) (result i32)))
  (func (export "_start")
    i32.const 176
    f64.const 288.0
    call $f3
    drop
    f64.const 97.0
    call $f0
    drop
    f32.const 96.0
    call $f1
    drop
    f64.const 31.0
    call $f2
    drop
  )
)
