(module
  (import "o2_h05_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 16
    i64.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 174
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 604
    i64.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 706
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 772
    i64.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 542
    i64.mul
    global.set $g
    global.get $g
    drop
  )
)
