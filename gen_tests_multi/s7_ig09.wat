(module
  (import "s7_ig09_host" "g0" (global $g0 i32))
  (import "s7_ig09_host" "g1" (global $g1 i64))
  (import "s7_ig09_host" "g2" (global $g2 f32))
  (import "s7_ig09_host" "g3" (global $g3 f64))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g1
    drop
    global.get $g2
    drop
    global.get $g3
    drop
  )
)
