(module
  (global (export "g0") (mut i64) (i64.const 342))
  (func (export "h0") (param i32) (result f64)
    local.get 0
    i32.const 29
    i32.add
    f64.convert_i32_s
  )
  (func (export "h1") (param i32) (result f32)
    local.get 0
    i32.const 7
    i32.add
    f32.convert_i32_s
  )
)
