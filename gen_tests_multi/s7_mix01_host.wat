(module
  (global (export "g0") f32 (f32.const 4528.0))
  (global (export "g1") i64 (i64.const 1720))
  (global (export "g2") f64 (f64.const 5003.0))
  (func (export "h0") (param i32) (result i32)
    local.get 0
    i32.const 37
    i32.add
  )
  (func (export "h1") (param i32) (result f64)
    local.get 0
    i32.const 1
    i32.add
    f64.convert_i32_s
  )
)
