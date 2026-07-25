(module
  (global $s (mut i32) (i32.const 73))
  (func (export "f0") (param i64) (param i64) (result i64)
    global.get $s
    i32.const 6
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f1") (param i64) (param i64) (result i64)
    global.get $s
    i32.const 3
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f2") (param i64) (param i64) (result i64)
    global.get $s
    i32.const 15
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f3") (param i64) (param i64) (result i64)
    global.get $s
    i32.const 3
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f4") (param i64) (param i64) (result i64)
    global.get $s
    i32.const 11
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
)
