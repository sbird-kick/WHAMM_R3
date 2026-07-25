(module
  (import "s7_c04_host" "f0" (func $f0 (param f64) (result f32)))
  (import "s7_c04_host" "f1" (func $f1 (param i64) (result f32)))
  (import "s7_c04_host" "f2" (func $f2 (param f32) (param f64) (result i64)))
  (import "s7_c04_host" "f3" (func $f3 (param i32) (result i64)))
  (func (export "_start")
    i32.const 183
    call $f3
    drop
    f64.const 239.0
    call $f0
    drop
    f32.const 122.0
    f64.const 68.0
    call $f2
    drop
    i64.const 206
    call $f1
    drop
  )
)
