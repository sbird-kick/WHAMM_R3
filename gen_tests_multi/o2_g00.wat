(module
  (import "o2_g00_host" "g0" (global $g0 f64))
  (import "o2_g00_host" "g1" (global $g1 i32))
  (import "o2_g00_host" "g2" (global $g2 i64))
  (import "o2_g00_host" "g3" (global $g3 f32))
  (import "o2_g00_host" "h0" (func $h0 (result i32)))
  (import "o2_g00_host" "h1" (func $h1 (result i32)))
  (import "o2_g00_host" "h2" (func $h2 (result i32)))
  (import "o2_g00_host" "h3" (func $h3 (result i32)))
  (import "o2_g00_host" "h4" (func $h4 (result i32)))
  (func (export "_start")
    global.get $g0
    drop
    call $h2
    drop
    global.get $g2
    drop
    call $h3
    drop
    global.get $g3
    drop
    call $h0
    drop
    global.get $g1
    drop
    call $h1
    drop
    call $h4
    drop
  )
)
