(module
  (global (export "g0") i32 (i32.const 1893))
  (global (export "g1") (mut i64) (i64.const 2996))
  (global (export "g2") f32 (f32.const 4978.0))
  (func (export "h0") (param i32) (result f64)
    local.get 0
    i32.const 3
    i32.add
    f64.convert_i32_s
  )
  (func (export "h1") (param i32) (result i64)
    local.get 0
    i32.const 26
    i32.add
    i64.extend_i32_s
  )
  (func (export "h2") (param i32) (result f32)
    local.get 0
    i32.const 39
    i32.add
    f32.convert_i32_s
  )
)
