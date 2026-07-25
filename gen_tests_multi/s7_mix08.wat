(module
  (import "s7_mix08_host" "g0" (global $g0 f32))
  (import "s7_mix08_host" "h0" (func $h0 (param i32) (result i64)))
  (import "s7_mix08_host" "h1" (func $h1 (param i32) (result i64)))
  (import "s7_mix08_host" "h2" (func $h2 (param i32) (result i32)))
  (func (export "_start")
    i32.const 119
    call $h0
    drop
    global.get $g0
    drop
    i32.const 56
    call $h2
    drop
    i32.const 57
    call $h1
    drop
  )
)
