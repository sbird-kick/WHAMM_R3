(module
  (import "s7_ig10_host" "g0" (global $g0 f64))
  (import "s7_ig10_host" "g1" (global $g1 f32))
  (import "s7_ig10_host" "g2" (global $g2 i64))
  (import "s7_ig10_host" "g3" (global $g3 i32))
  (func (export "_start")
    global.get $g1
    drop
    global.get $g3
    drop
    global.get $g0
    drop
    global.get $g2
    drop
  )
)
