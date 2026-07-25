(module
  (import "o2_a10_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 232
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 441
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 658
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 23
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 276
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 125
    i32.add
    global.set $g
    global.get $g
    drop
  )
)
