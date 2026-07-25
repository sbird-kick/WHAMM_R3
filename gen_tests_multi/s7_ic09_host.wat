(module
  (global $s (mut i32) (i32.const 25))
  (func (export "f0")  (result i32)
    global.get $s
    i32.const 10
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f1")  (result i32)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f2")  (result i32)
    global.get $s
    i32.const 2
    i32.add
    global.set $s
    global.get $s
  )
  (func (export "f3")  (result i32)
    global.get $s
    i32.const 18
    i32.add
    global.set $s
    global.get $s
  )
)
