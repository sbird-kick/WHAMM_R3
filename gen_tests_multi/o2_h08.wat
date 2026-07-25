(module
  (import "o2_h08_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 683
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 469
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 375
    i32.xor
    global.set $g
    global.get $g
    drop
  )
)
