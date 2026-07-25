(module
  (import "s7_ic06_host" "f0" (func $f0 (param i64) (param i64) (result i64)))
  (import "s7_ic06_host" "f1" (func $f1 (param i64) (param i64) (result i64)))
  (import "s7_ic06_host" "f2" (func $f2 (param i64) (param i64) (result i64)))
  (import "s7_ic06_host" "f3" (func $f3 (param i64) (param i64) (result i64)))
  (import "s7_ic06_host" "f4" (func $f4 (param i64) (param i64) (result i64)))
  (func (export "_start")
    i64.const 315
    i64.const 67
    call $f1
    drop
    i64.const 330
    i64.const 445
    call $f4
    drop
    i64.const 55
    i64.const 309
    call $f2
    drop
    i64.const 152
    i64.const 237
    call $f3
    drop
    i64.const 340
    i64.const 289
    call $f0
    drop
  )
)
