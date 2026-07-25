(module
  (import "s7_mix06_host" "g0" (global $g0 f32))
  (import "s7_mix06_host" "g1" (global $g1 i32))
  (import "s7_mix06_host" "g2" (global $g2 f64))
  (import "s7_mix06_host" "h0" (func $h0 (param i32) (result i64)))
  (import "s7_mix06_host" "h1" (func $h1 (param i32) (result f64)))
  (import "s7_mix06_host" "h2" (func $h2 (param i32) (result f32)))
  (func (export "_start")
    global.get $g0
    drop
    i32.const 157
    call $h2
    drop
    i32.const 168
    call $h0
    drop
    global.get $g2
    drop
    i32.const 188
    call $h1
    drop
    global.get $g1
    drop
  )
)
