(module
  (global $s (mut i32) (i32.const 80))
  (func (export "tick") (param i32) (result i32)
    global.get $s
    local.get 0
    i32.add
    global.set $s
    global.get $s)
  (func (export "peek") (result i32)
    global.get $s)
)
