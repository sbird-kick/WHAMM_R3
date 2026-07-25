(module
  (import "s7_ic14_host" "f0" (func $f0 (param i64) (result f32)))
  (import "s7_ic14_host" "f1" (func $f1 (param i64) (result f32)))
  (import "s7_ic14_host" "f2" (func $f2 (param i64) (result f32)))
  (import "s7_ic14_host" "f3" (func $f3 (param i64) (result f32)))
  (func (export "_start")
    i64.const 61
    call $f0
    drop
    i64.const 412
    call $f1
    drop
    i64.const 253
    call $f3
    drop
    i64.const 31
    call $f2
    drop
  )
)
