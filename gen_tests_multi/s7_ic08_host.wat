(module
  (global $s (mut i32) (i32.const 33))
  (func (export "f0") (param f64) (param f64) (result f64)
    global.get $s
    i32.const 3
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f1") (param f64) (param f64) (result f64)
    global.get $s
    i32.const 11
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f2") (param f64) (param f64) (result f64)
    global.get $s
    i32.const 2
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f3") (param f64) (param f64) (result f64)
    global.get $s
    i32.const 9
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
  (func (export "f4") (param f64) (param f64) (result f64)
    global.get $s
    i32.const 17
    i32.add
    global.set $s
    global.get $s
    f64.convert_i32_s
  )
)
