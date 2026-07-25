(module
  (import "s7_mix07_host" "g0" (global $g0 (mut i64)))
  (import "s7_mix07_host" "h0" (func $h0 (param i32) (result f64)))
  (import "s7_mix07_host" "h1" (func $h1 (param i32) (result f32)))
  (func (export "_start")
    i32.const 179
    call $h1
    drop
    i32.const 188
    call $h0
    drop
    global.get $g0
    drop
    global.get $g0
    i64.const 7
    i64.add
    global.set $g0
  )
)
