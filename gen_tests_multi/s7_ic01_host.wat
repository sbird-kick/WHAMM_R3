(module
  (global $s (mut i32) (i32.const 49))
  (func (export "f0") (param i32) (result i32)
    global.get $s
    i32.const 6
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f1") (param i32) (result i32)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
  )
)
