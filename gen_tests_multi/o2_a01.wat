(module
  (import "o2_a01_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 408
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 13
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 662
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 487
    i32.add
    global.set $g
    global.get $g
    drop
  )
)
