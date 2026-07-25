(module
  (import "s7_mix03_host" "g0" (global $g0 f64))
  (import "s7_mix03_host" "h0" (func $h0 (param i32) (result i64)))
  (import "s7_mix03_host" "h1" (func $h1 (param i32) (result i64)))
  (func (export "_start")
    i32.const 87
    call $h0
    drop
    global.get $g0
    drop
    i32.const 175
    call $h1
    drop
  )
)
