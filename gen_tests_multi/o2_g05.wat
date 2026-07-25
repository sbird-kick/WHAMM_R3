(module
  (import "o2_g05_host" "g0" (global $g0 i32))
  (import "o2_g05_host" "g1" (global $g1 i64))
  (import "o2_g05_host" "g2" (global $g2 f32))
  (import "o2_g05_host" "g3" (global $g3 f64))
  (import "o2_g05_host" "g4" (global $g4 i32))
  (import "o2_g05_host" "h0" (func $h0 (result i32)))
  (import "o2_g05_host" "h1" (func $h1 (result i32)))
  (import "o2_g05_host" "h2" (func $h2 (result i32)))
  (func (export "_start")
    global.get $g0
    drop
    call $h0
    drop
    global.get $g1
    drop
    call $h2
    drop
    global.get $g2
    drop
    call $h1
    drop
    global.get $g4
    drop
    global.get $g3
    drop
  )
)
