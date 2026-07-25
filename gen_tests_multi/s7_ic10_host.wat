(module
  (global $s (mut i32) (i32.const 99))
  (func (export "f0")  (result i64)
    global.get $s
    i32.const 19
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f1")  (result i64)
    global.get $s
    i32.const 13
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f2")  (result i64)
    global.get $s
    i32.const 7
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
)
