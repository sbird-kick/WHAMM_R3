(module
  (import "o2_c09_host" "g0" (global $g0 i64))
  (import "o2_c09_host" "g1" (global $g1 f32))
  (import "o2_c09_host" "g2" (global $g2 f64))
  (func (export "_start")
    global.get $g2
    drop
    global.get $g0
    drop
    global.get $g1
    drop
    global.get $g1
    drop
    global.get $g1
    drop
  )
)
