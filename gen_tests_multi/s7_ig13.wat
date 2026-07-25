(module
  (import "s7_ig13_host" "g0" (global $g0 (mut i32)))
  (import "s7_ig13_host" "g1" (global $g1 f32))
  (import "s7_ig13_host" "g2" (global $g2 f64))
  (import "s7_ig13_host" "g3" (global $g3 i64))
  (func (export "_start")
    global.get $g3
    drop
    global.get $g0
    drop
    global.get $g0
    i32.const 560
    i32.add
    global.set $g0
    global.get $g0
    drop
    global.get $g2
    drop
    global.get $g1
    drop
  )
)
