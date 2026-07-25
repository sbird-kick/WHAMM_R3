(module
  (import "s7_c01_host" "f0" (func $f0 (param f32) (result f32)))
  (import "s7_c01_host" "f1" (func $f1 (param f32) (param f64) (result i64)))
  (func (export "_start")
    f32.const 88.0
    f64.const 176.0
    call $f1
    drop
    f32.const 278.0
    call $f0
    drop
  )
)
