(module
  (import "o2_h09_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 536
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 158
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 464
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 450
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 748
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 726
    i64.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 744
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 74
    i64.or
    global.set $g
    global.get $g
    drop
  )
)
