(module
  (import "s7_rs05_host" "f0" (func $f0 (param f64) (result f64)))
  (import "s7_rs05_host" "f1" (func $f1 (param i32) (param i64) (result i64)))
  (import "s7_rs05_host" "f2" (func $f2 (param i32) (result i32)))
  (import "s7_rs05_host" "f3" (func $f3 (param i64) (result i64)))
  (func (export "_start")
    f64.const 270.0
    call $f0
    drop
    i64.const 205
    call $f3
    drop
    i32.const 34
    call $f2
    drop
    i32.const 70
    i64.const 3
    call $f1
    drop
  )
)
