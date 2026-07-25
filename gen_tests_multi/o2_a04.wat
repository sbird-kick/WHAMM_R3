(module
  (import "o2_a04_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 588
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
    global.get $g
    i32.const 626
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 755
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 72
    i32.add
    global.set $g
    global.get $g
    drop
  )
)
