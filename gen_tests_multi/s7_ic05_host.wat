(module
  (global $s (mut i32) (i32.const 20))
  (func (export "f0") (param i32) (param i32) (result i32)
    global.get $s
    i32.const 10
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f1") (param i32) (param i32) (result i32)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f2") (param i32) (param i32) (result i32)
    global.get $s
    i32.const 13
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f3") (param i32) (param i32) (result i32)
    global.get $s
    i32.const 1
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f4") (param i32) (param i32) (result i32)
    global.get $s
    i32.const 9
    i32.add
    global.set $s
    global.get $s
  )
)
