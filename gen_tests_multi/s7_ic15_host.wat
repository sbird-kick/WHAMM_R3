(module
  (global $s (mut i32) (i32.const 18))
  (func (export "f0") (param f64) (param i32) (result i64)
    global.get $s
    i32.const 11
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f1") (param f64) (param i32) (result i64)
    global.get $s
    i32.const 15
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f2") (param f64) (param i32) (result i64)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f3") (param f64) (param i32) (result i64)
    global.get $s
    i32.const 12
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
  (func (export "f4") (param f64) (param i32) (result i64)
    global.get $s
    i32.const 12
    i32.add
    global.set $s
    global.get $s
    i64.extend_i32_s
  )
)
