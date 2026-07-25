(module
  (import "s7_rs03_host" "f0" (func $f0 (param i32) (result f32)))
  (import "s7_rs03_host" "f1" (func $f1 (param f32) (result i32)))
  (import "s7_rs03_host" "f2" (func $f2 (param f64) (result i32)))
  (import "s7_rs03_host" "f3" (func $f3 (param i32) (param i32) (result f32)))
  (func (export "_start")
    f32.const 127.0
    call $f1
    drop
    f64.const 3.0
    call $f2
    drop
    i32.const 211
    call $f0
    drop
    i32.const 197
    i32.const 115
    call $f3
    drop
  )
)
