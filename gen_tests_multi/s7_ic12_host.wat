(module
  (global $s (mut i32) (i32.const 52))
  (func (export "f0") (param i32) (param i64) (result f64)
    global.get $s
    i32.const 17
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f1") (param i32) (param i64) (result f64)
    global.get $s
    i32.const 13
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f2") (param i32) (param i64) (result f64)
    global.get $s
    i32.const 3
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f3") (param i32) (param i64) (result f64)
    global.get $s
    i32.const 15
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f4") (param i32) (param i64) (result f64)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
)
