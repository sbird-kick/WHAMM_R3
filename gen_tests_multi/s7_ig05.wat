(module
  (import "s7_ig05_host" "g0" (global $g0 (mut i32)))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g0
    i32.const 277
    i32.add
    global.set $g0
    global.get $g0
    drop
  )
)
