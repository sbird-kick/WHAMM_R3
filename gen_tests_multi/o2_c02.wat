(module
  (import "o2_c02_host" "g0" (global $g0 i32))
  (import "o2_c02_host" "g1" (global $g1 i64))
  (import "o2_c02_host" "g2" (global $g2 f32))
  (import "o2_c02_host" "g3" (global $g3 f64))
  (import "o2_c02_host" "g4" (global $g4 i32))
  (import "o2_c02_host" "g5" (global $g5 i64))
  (func (export "_start")
    global.get $g3
    drop
    global.get $g5
    drop
    global.get $g1
    drop
    global.get $g4
    drop
    global.get $g2
    drop
    global.get $g0
    drop
    global.get $g0
    drop
  )
)
