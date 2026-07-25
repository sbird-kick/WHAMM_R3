(module
  (import "o2_h03_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 728
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 238
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 216
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 670
    i64.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 416
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 626
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 464
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 350
    i64.sub
    global.set $g
    global.get $g
    drop
  )
)
