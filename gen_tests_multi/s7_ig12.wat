(module
  (import "s7_ig12_host" "g0" (global $g0 (mut i64)))
  (import "s7_ig12_host" "g1" (global $g1 (mut i64)))
  (func (export "_start")
    global.get $g1
    drop
    global.get $g1
    i64.const 834
    i64.add
    global.set $g1
    global.get $g1
    drop
    global.get $g0
    drop
    global.get $g0
    i64.const 831
    i64.add
    global.set $g0
    global.get $g0
    drop
  )
)
