(module
  (import "s7_ic01_host" "f0" (func $f0 (param i32) (result i32)))
  (import "s7_ic01_host" "f1" (func $f1 (param i32) (result i32)))
  (func (export "_start")
    i32.const 275
    call $f1
    drop
    i32.const 202
    call $f0
    drop
  )
)
