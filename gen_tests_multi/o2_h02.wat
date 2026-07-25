(module
  (import "o2_h02_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 327
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 633
    i32.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 471
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 269
    i32.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 623
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 309
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 487
    i32.mul
    global.set $g
    global.get $g
    drop
  )
)
