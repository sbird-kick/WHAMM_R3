(module
  (global (export "g0") f32 (f32.const 7026.0))
  (func (export "h0") (param i32) (result i64)
    local.get 0
    i32.const 24
    i32.add
    i64.extend_i32_s
  )
  (func (export "h1") (param i32) (result i64)
    local.get 0
    i32.const 2
    i32.add
    i64.extend_i32_s
  )
  (func (export "h2") (param i32) (result i32)
    local.get 0
    i32.const 39
    i32.add
  )
)
