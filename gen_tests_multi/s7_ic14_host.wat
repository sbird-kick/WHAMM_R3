(module
  (global $s (mut i32) (i32.const 48))
  (func (export "f0") (param i64) (result f32)
    global.get $s
    i32.const 5
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f1") (param i64) (result f32)
    global.get $s
    i32.const 6
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f2") (param i64) (result f32)
    global.get $s
    i32.const 14
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f3") (param i64) (result f32)
    global.get $s
    i32.const 15
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
)
