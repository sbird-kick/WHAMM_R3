(module
  (global $s (mut i32) (i32.const 98))
  (func (export "f0") (param f32) (param i32) (result f32)
    global.get $s
    i32.const 2
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f1") (param f32) (param i32) (result f32)
    global.get $s
    i32.const 17
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f2") (param f32) (param i32) (result f32)
    global.get $s
    i32.const 20
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f3") (param f32) (param i32) (result f32)
    global.get $s
    i32.const 6
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
  (func (export "f4") (param f32) (param i32) (result f32)
    global.get $s
    i32.const 9
    i32.add
    global.set $s
    global.get $s
    f32.convert_i32_s
  )
)
