(module
  (import "o2_f02_host" "f0" (func $f0 (result i32)))
  (import "o2_f02_host" "f1" (func $f1 (result i32)))
  (import "o2_f02_host" "f2" (func $f2 (result i32)))
  (import "o2_f02_host" "f3" (func $f3 (result i32)))
  (import "o2_f02_host" "f4" (func $f4 (result i32)))
  (func (export "_start")
    call $f0
    drop
    call $f2
    drop
    call $f3
    drop
    call $f1
    drop
    call $f4
    drop
  )
)
