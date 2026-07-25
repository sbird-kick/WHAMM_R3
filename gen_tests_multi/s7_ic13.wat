(module
  (import "s7_ic13_host" "f0" (func $f0 (param f32) (param i32) (result f32)))
  (import "s7_ic13_host" "f1" (func $f1 (param f32) (param i32) (result f32)))
  (import "s7_ic13_host" "f2" (func $f2 (param f32) (param i32) (result f32)))
  (import "s7_ic13_host" "f3" (func $f3 (param f32) (param i32) (result f32)))
  (import "s7_ic13_host" "f4" (func $f4 (param f32) (param i32) (result f32)))
  (func (export "_start")
    f32.const 398.0
    i32.const 427
    call $f0
    drop
    f32.const 168.0
    i32.const 83
    call $f4
    drop
    f32.const 89.0
    i32.const 408
    call $f1
    drop
    f32.const 33.0
    i32.const 415
    call $f3
    drop
    f32.const 167.0
    i32.const 294
    call $f2
    drop
  )
)
