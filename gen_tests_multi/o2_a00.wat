(module
  (import "o2_a00_host" "g" (global $g (mut f64)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    f64.const 555.0
    f64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    f64.const 800.0
    f64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    f64.const 425.0
    f64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    f64.const 558.0
    f64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    f64.const 159.0
    f64.add
    global.set $g
    global.get $g
    drop
    global.get $g
    f64.const 176.0
    f64.add
    global.set $g
    global.get $g
    drop
  )
)
