(module
  (import "s7_mix02_host" "g0" (global $g0 i32))
  (import "s7_mix02_host" "g1" (global $g1 (mut i64)))
  (import "s7_mix02_host" "g2" (global $g2 f32))
  (import "s7_mix02_host" "h0" (func $h0 (param i32) (result f64)))
  (import "s7_mix02_host" "h1" (func $h1 (param i32) (result i64)))
  (import "s7_mix02_host" "h2" (func $h2 (param i32) (result f32)))
  (func (export "_start")
    i32.const 38
    call $h1
    drop
    global.get $g0
    drop
    global.get $g2
    drop
    global.get $g1
    drop
    global.get $g1
    i64.const 77
    i64.add
    global.set $g1
    i32.const 2
    call $h0
    drop
    i32.const 145
    call $h2
    drop
  )
)
