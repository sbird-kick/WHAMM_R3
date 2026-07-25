(module
  (import "o2_h00_host" "g" (global $g (mut i32)))
  (func (export "_start")
    global.get $g
    drop
    global.get $g
    i32.const 663
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 213
    i32.or
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 847
    i32.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 117
    i32.sub
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 803
    i32.mul
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 165
    i32.xor
    global.set $g
    global.get $g
    drop
    global.get $g
    i32.const 687
    i32.sub
    global.set $g
    global.get $g
    drop
  )
)
