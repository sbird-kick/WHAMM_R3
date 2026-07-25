(module
  (import "s7_ic08_host" "f0" (func $f0 (param f64) (param f64) (result f64)))
  (import "s7_ic08_host" "f1" (func $f1 (param f64) (param f64) (result f64)))
  (import "s7_ic08_host" "f2" (func $f2 (param f64) (param f64) (result f64)))
  (import "s7_ic08_host" "f3" (func $f3 (param f64) (param f64) (result f64)))
  (import "s7_ic08_host" "f4" (func $f4 (param f64) (param f64) (result f64)))
  (func (export "_start")
    f64.const 406.0
    f64.const 48.0
    call $f3
    drop
    f64.const 475.0
    f64.const 297.0
    call $f4
    drop
    f64.const 92.0
    f64.const 338.0
    call $f2
    drop
    f64.const 289.0
    f64.const 466.0
    call $f1
    drop
    f64.const 475.0
    f64.const 252.0
    call $f0
    drop
  )
)
