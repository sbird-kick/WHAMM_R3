(module
  (import "o2_h01_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 612
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 162
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 284
    i64.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 10
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 540
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 438
    i64.xor
    global.set $g
    global.get $g
    drop
  )
)
