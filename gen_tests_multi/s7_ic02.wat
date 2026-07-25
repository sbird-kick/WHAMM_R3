(module
  (import "s7_ic02_host" "f0" (func $f0 (param i64) (result i64)))
  (import "s7_ic02_host" "f1" (func $f1 (param i64) (result i64)))
  (import "s7_ic02_host" "f2" (func $f2 (param i64) (result i64)))
  (import "s7_ic02_host" "f3" (func $f3 (param i64) (result i64)))
  (func (export "_start")
    i64.const 301
    call $f2
    drop
    i64.const 452
    call $f1
    drop
    i64.const 136
    call $f3
    drop
    i64.const 332
    call $f0
    drop
  )
)
