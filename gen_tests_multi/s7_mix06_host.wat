(module
  (global (export "g0") f32 (f32.const 3731.0))
  (global (export "g1") i32 (i32.const 5026))
  (global (export "g2") f64 (f64.const 6220.0))
  (func (export "h0") (param i32) (result i64)
    local.get 0
    i32.const 18
    i32.add
    i64.extend_i32_s
  )
  (func (export "h1") (param i32) (result f64)
    local.get 0
    i32.const 28
    i32.add
    f64.convert_i32_s
  )
  (func (export "h2") (param i32) (result f32)
    local.get 0
    i32.const 37
    i32.add
    f32.convert_i32_s
  )
)
