(module
  (import "o2_a06_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 321
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 354
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 307
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 852
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 165
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 798
    i64.add
    global.set $g
    global.get $g
    drop
  )
)
