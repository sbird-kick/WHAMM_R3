(module
  (import "s7_ic15_host" "f0" (func $f0 (param f64) (param i32) (result i64)))
  (import "s7_ic15_host" "f1" (func $f1 (param f64) (param i32) (result i64)))
  (import "s7_ic15_host" "f2" (func $f2 (param f64) (param i32) (result i64)))
  (import "s7_ic15_host" "f3" (func $f3 (param f64) (param i32) (result i64)))
  (import "s7_ic15_host" "f4" (func $f4 (param f64) (param i32) (result i64)))
  (func (export "_start")
    f64.const 352.0
    i32.const 382
    call $f4
    drop
    f64.const 254.0
    i32.const 73
    call $f2
    drop
    f64.const 460.0
    i32.const 118
    call $f0
    drop
    f64.const 123.0
    i32.const 36
    call $f3
    drop
    f64.const 369.0
    i32.const 419
    call $f1
    drop
  )
)
