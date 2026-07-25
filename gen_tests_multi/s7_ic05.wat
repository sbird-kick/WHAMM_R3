(module
  (import "s7_ic05_host" "f0" (func $f0 (param i32) (param i32) (result i32)))
  (import "s7_ic05_host" "f1" (func $f1 (param i32) (param i32) (result i32)))
  (import "s7_ic05_host" "f2" (func $f2 (param i32) (param i32) (result i32)))
  (import "s7_ic05_host" "f3" (func $f3 (param i32) (param i32) (result i32)))
  (import "s7_ic05_host" "f4" (func $f4 (param i32) (param i32) (result i32)))
  (func (export "_start")
    i32.const 82
    i32.const 71
    call $f0
    drop
    i32.const 167
    i32.const 42
    call $f1
    drop
    i32.const 472
    i32.const 146
    call $f4
    drop
    i32.const 137
    i32.const 155
    call $f2
    drop
    i32.const 219
    i32.const 81
    call $f3
    drop
  )
)
