(module
  (import "o2_h06_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 47
    i32.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 493
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 275
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 877
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 899
    i32.mul
    global.set $g
    global.get $g
    drop
  )
)
