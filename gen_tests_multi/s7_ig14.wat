(module
  (import "s7_ig14_host" "g0" (global $g0 (mut i64)))
  (import "s7_ig14_host" "g1" (global $g1 i32))
  (import "s7_ig14_host" "g2" (global $g2 f64))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g0
    i64.const 97
    i64.add
    global.set $g0
    global.get $g0
    drop
    global.get $g1
    drop
    global.get $g2
    drop
  )
)
