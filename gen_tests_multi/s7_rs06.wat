(module
  (import "s7_rs06_host" "f0" (func $f0 (param i64) (param i64) (result i64)))
  (import "s7_rs06_host" "f1" (func $f1 (param f64) (result i64)))
  (import "s7_rs06_host" "f2" (func $f2 (param f64) (result f64)))
  (import "s7_rs06_host" "f3" (func $f3 (param f64) (result i32)))
  (func (export "_start")
    f64.const 281.0
    call $f3
    drop
    i64.const 146
    i64.const 147
    call $f0
    drop
    f64.const 141.0
    call $f1
    drop
    f64.const 190.0
    call $f2
    drop
  )
)
