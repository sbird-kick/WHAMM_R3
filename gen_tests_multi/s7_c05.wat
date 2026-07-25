(module
  (import "s7_c05_host" "f0" (func $f0 (param f64) (result f64)))
  (import "s7_c05_host" "f1" (func $f1 (param i64) (param i32) (result f64)))
  (import "s7_c05_host" "f2" (func $f2 (param f32) (result i64)))
  (func (export "_start")
    i64.const 233
    i32.const 146
    call $f1
    drop
    f64.const 96.0
    call $f0
    drop
    f32.const 99.0
    call $f2
    drop
  )
)
