(module
  (import "s7_ic07_host" "f0" (func $f0 (param f32) (param f32) (result f32)))
  (import "s7_ic07_host" "f1" (func $f1 (param f32) (param f32) (result f32)))
  (import "s7_ic07_host" "f2" (func $f2 (param f32) (param f32) (result f32)))
  (import "s7_ic07_host" "f3" (func $f3 (param f32) (param f32) (result f32)))
  (import "s7_ic07_host" "f4" (func $f4 (param f32) (param f32) (result f32)))
  (func (export "_start")
    f32.const 382.0
    f32.const 185.0
    call $f0
    drop
    f32.const 401.0
    f32.const 140.0
    call $f2
    drop
    f32.const 347.0
    f32.const 408.0
    call $f3
    drop
    f32.const 32.0
    f32.const 423.0
    call $f4
    drop
    f32.const 336.0
    f32.const 213.0
    call $f1
    drop
  )
)
