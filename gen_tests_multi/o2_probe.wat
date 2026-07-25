(module
  (import "o2_probe_host" "g" (global $g (mut i32)))
  (import "o2_probe_host" "bump" (func $bump (param i32) (result i32)))
  (func (export "_start")
    global.get $g
    drop
    i32.const 5
    call $bump
    drop
    global.get $g
    drop
    global.get $g
    i32.const 100
    i32.add
    global.set $g
    global.get $g
    drop
  )
)
