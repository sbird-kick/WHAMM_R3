(module
  (import "s7_c03_host" "f0" (func $f0 (param i32) (result i32)))
  (import "s7_c03_host" "f1" (func $f1 (param i32) (result f32)))
  (import "s7_c03_host" "f2" (func $f2 (param i32) (param f64) (result f32)))
  (import "s7_c03_host" "f3" (func $f3 (param f64) (param f64) (result f32)))
  (func (export "_start")
    i32.const 61
    f64.const 130.0
    call $f2
    drop
    i32.const 300
    call $f0
    drop
    i32.const 222
    call $f1
    drop
    f64.const 235.0
    f64.const 147.0
    call $f3
    drop
  )
)
