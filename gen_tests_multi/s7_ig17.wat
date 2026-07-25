(module
  (import "s7_ig17_host" "g0" (global $g0 i64))
  (import "s7_ig17_host" "g1" (global $g1 i64))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g1
    drop
  )
)
