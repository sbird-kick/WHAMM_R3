(module
  (global (export "g0") f64 (f64.const 8726.0))
  (func (export "h0") (param i32) (result i64)
    local.get 0
    i32.const 25
    i32.add
    i64.extend_i32_s
  )
  (func (export "h1") (param i32) (result i64)
    local.get 0
    i32.const 30
    i32.add
    i64.extend_i32_s
  )
)
