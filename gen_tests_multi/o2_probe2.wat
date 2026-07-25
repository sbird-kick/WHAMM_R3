(module
  (import "o2_probe2_host" "f0" (func $f0 (result i32)))
  (import "o2_probe2_host" "f1" (func $f1 (result i32)))
  (import "o2_probe2_host" "f2" (func $f2 (result i32)))
  (func (export "_start")
    call $f2 drop
    call $f0 drop
    call $f1 drop)
)
