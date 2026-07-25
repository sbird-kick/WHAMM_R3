(module
  (import "o2_a09_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 893
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 382
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 663
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 40
    i64.add
    global.set $g
    global.get $g
    drop
  )
)
