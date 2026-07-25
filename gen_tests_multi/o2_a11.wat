(module
  (import "o2_a11_host" "g" (global $g (mut i64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i64.const 109
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 6
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 615
    i64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    i64.const 292
    i64.add
    global.set $g
    global.get $g
    drop
  )
)
