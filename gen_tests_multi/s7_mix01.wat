(module
  (import "s7_mix01_host" "g0" (global $g0 f32))
  (import "s7_mix01_host" "g1" (global $g1 i64))
  (import "s7_mix01_host" "g2" (global $g2 f64))
  (import "s7_mix01_host" "h0" (func $h0 (param i32) (result i32)))
  (import "s7_mix01_host" "h1" (func $h1 (param i32) (result f64)))
  (func (export "_start")
    i32.const 108
    call $h1
    drop
    global.get $g2
    drop
    global.get $g1
    drop
    i32.const 162
    call $h0
    drop
    global.get $g0
    drop
  )
)
