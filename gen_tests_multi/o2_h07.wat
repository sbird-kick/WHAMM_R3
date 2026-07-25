(module
  (import "o2_h07_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 404
    i64.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 510
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 740
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 554
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 280
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 598
    i64.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 896
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 418
    i64.or
    global.set $g
    global.get $g
    drop
  )
)
