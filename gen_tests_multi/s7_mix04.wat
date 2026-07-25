(module
  (import "s7_mix04_host" "g0" (global $g0 f32))
  (import "s7_mix04_host" "h0" (func $h0 (param i32) (result f32)))
  (import "s7_mix04_host" "h1" (func $h1 (param i32) (result i32)))
  (func (export "_start")
    i32.const 59
    call $h0
    drop
    i32.const 92
    call $h1
    drop
    global.get $g0
    drop
  )
)
