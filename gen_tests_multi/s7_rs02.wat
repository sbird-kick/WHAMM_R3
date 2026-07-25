(module
  (import "s7_rs02_host" "f0" (func $f0 (param f64) (param i64) (result f64)))
  (import "s7_rs02_host" "f1" (func $f1 (param i64) (result f64)))
  (func (export "_start")
    i64.const 287
    call $f1
    drop
    f64.const 16.0
    i64.const 48
    call $f0
    drop
  )
)
