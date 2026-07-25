(module
  (import "o2_a05_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 744
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 769
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 678
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 563
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 620
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 333
    i32.add
    global.set $g
    global.get $g
    drop
  )
)
