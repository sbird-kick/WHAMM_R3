(module
  (import "o2_f10_host" "f0" (func $f0 (result i32)))
  (import "o2_f10_host" "f1" (func $f1 (result i32)))
  (import "o2_f10_host" "f2" (func $f2 (result i32)))
  (import "o2_f10_host" "f3" (func $f3 (result i32)))
  (import "o2_f10_host" "f4" (func $f4 (result i32)))
  (import "o2_f10_host" "f5" (func $f5 (result i32)))
  (import "o2_f10_host" "f6" (func $f6 (result i32)))
  (func (export "_start")
    call $f4
    drop
    call $f1
    drop
    call $f6
    drop
    call $f3
    drop
    call $f0
    drop
    call $f5
    drop
    call $f2
    drop
  )
)
