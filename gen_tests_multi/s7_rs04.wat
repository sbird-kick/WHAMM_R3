(module
  (import "s7_rs04_host" "f0" (func $f0 (param f64) (param f64) (result f64)))
  (import "s7_rs04_host" "f1" (func $f1 (param i64) (param i64) (result f64)))
  (import "s7_rs04_host" "f2" (func $f2 (param i32) (param i32) (result f64)))
  (func (export "_start")
    i32.const 129
    i32.const 150
    call $f2
    drop
    f64.const 128.0
    f64.const 154.0
    call $f0
    drop
    i64.const 86
    i64.const 13
    call $f1
    drop
  )
)
