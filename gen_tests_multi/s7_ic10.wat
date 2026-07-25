(module
  (import "s7_ic10_host" "f0" (func $f0  (result i64)))
  (import "s7_ic10_host" "f1" (func $f1  (result i64)))
  (import "s7_ic10_host" "f2" (func $f2  (result i64)))
  (func (export "_start")
    call $f2
    drop
    call $f1
    drop
    call $f0
    drop
  )
)
