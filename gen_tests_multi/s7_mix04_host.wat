(module
  (global (export "g0") f32 (f32.const 2011.0))
  (func (export "h0") (param i32) (result f32)
    local.get 0
    i32.const 28
    i32.add
    f32.convert_i32_s
  )
  (func (export "h1") (param i32) (result i32)
    local.get 0
    i32.const 9
    i32.add
  )
)
