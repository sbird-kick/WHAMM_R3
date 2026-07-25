(module
  (import "s7_c02_host" "f0" (func $f0 (param i64) (result i32)))
  (import "s7_c02_host" "f1" (func $f1 (param i64) (result f64)))
  (import "s7_c02_host" "f2" (func $f2 (param f64) (result f64)))
  (import "s7_c02_host" "f3" (func $f3 (param i32) (result i32)))
  (func (export "_start")
    i64.const 96
    call $f1
    drop
    i64.const 173
    call $f0
    drop
    i32.const 85
    call $f3
    drop
    f64.const 126.0
    call $f2
    drop
  )
)
