(module
  (import "o2_c11_host" "g0" (global $g0 f32))
  (import "o2_c11_host" "g1" (global $g1 f64))
  (import "o2_c11_host" "g2" (global $g2 i32))
  (import "o2_c11_host" "g3" (global $g3 i64))
  (func (export "_start")
    global.get $g1
    drop
    global.get $g0
    drop
    global.get $g3
    drop
    global.get $g2
    drop
    global.get $g2
    drop
    global.get $g3
    drop
  )
)
