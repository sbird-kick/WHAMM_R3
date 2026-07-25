(module
  (import "o2_h04_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 307
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 133
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 355
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 829
    i32.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 319
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 401
    i32.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 255
    i32.sub
    global.set $g
    global.get $g
    drop
  )
)
