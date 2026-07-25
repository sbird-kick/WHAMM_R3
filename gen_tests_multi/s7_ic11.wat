(module
  (import "s7_ic11_host" "f0" (func $f0 (param i32) ))
  (import "s7_ic11_host" "f1" (func $f1 (param i32) ))
  (import "s7_ic11_host" "f2" (func $f2 (param i32) ))
  (import "s7_ic11_host" "f3" (func $f3 (param i32) ))
  (import "s7_ic11_host" "f4" (func $f4 (param i32) ))
  (func (export "_start")
    i32.const 125
    call $f3
    i32.const 328
    call $f2
    i32.const 272
    call $f0
    i32.const 500
    call $f4
    i32.const 83
    call $f1
  )
)
