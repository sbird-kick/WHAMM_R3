(module
  (import "s7_ic12_host" "f0" (func $f0 (param i32) (param i64) (result f64)))
  (import "s7_ic12_host" "f1" (func $f1 (param i32) (param i64) (result f64)))
  (import "s7_ic12_host" "f2" (func $f2 (param i32) (param i64) (result f64)))
  (import "s7_ic12_host" "f3" (func $f3 (param i32) (param i64) (result f64)))
  (import "s7_ic12_host" "f4" (func $f4 (param i32) (param i64) (result f64)))
  (func (export "_start")
    i32.const 103
    i64.const 287
    call $f3
    drop
    i32.const 212
    i64.const 254
    call $f1
    drop
    i32.const 427
    i64.const 230
    call $f4
    drop
    i32.const 397
    i64.const 273
    call $f0
    drop
    i32.const 360
    i64.const 214
    call $f2
    drop
  )
)
