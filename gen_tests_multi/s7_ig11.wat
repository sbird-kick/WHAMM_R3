(module
  (import "s7_ig11_host" "g0" (global $g0 (mut i32)))
  (import "s7_ig11_host" "g1" (global $g1 (mut i32)))
  (import "s7_ig11_host" "g2" (global $g2 (mut i32)))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g0
    i32.const 110
    i32.add
    global.set $g0
    global.get $g0
    drop
    global.get $g2
    drop
    global.get $g2
    i32.const 646
    i32.add
    global.set $g2
    global.get $g2
    drop
    global.get $g1
    drop
    global.get $g1
    i32.const 683
    i32.add
    global.set $g1
    global.get $g1
    drop
  )
)
