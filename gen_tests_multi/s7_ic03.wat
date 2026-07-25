(module
  (import "s7_ic03_host" "f0" (func $f0 (param f32) (result f32)))
  (import "s7_ic03_host" "f1" (func $f1 (param f32) (result f32)))
  (import "s7_ic03_host" "f2" (func $f2 (param f32) (result f32)))
  (import "s7_ic03_host" "f3" (func $f3 (param f32) (result f32)))
  (func (export "_start")
    f32.const 419.0
    call $f3
    drop
    f32.const 208.0
    call $f1
    drop
    f32.const 217.0
    call $f2
    drop
    f32.const 205.0
    call $f0
    drop
  )
)
