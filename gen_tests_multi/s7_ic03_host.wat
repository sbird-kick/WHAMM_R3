(module
  (global $s (mut i32) (i32.const 2))
  (func (export "f0") (param f32) (result f32)
    global.get $s
    i32.const 6
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f1") (param f32) (result f32)
    global.get $s
    i32.const 4
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f2") (param f32) (result f32)
    global.get $s
    i32.const 16
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f3") (param f32) (result f32)
    global.get $s
    i32.const 13
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
)
