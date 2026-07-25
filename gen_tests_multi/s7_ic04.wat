(module
  (import "s7_ic04_host" "f0" (func $f0 (param f64) (result f64)))
  (import "s7_ic04_host" "f1" (func $f1 (param f64) (result f64)))
  (import "s7_ic04_host" "f2" (func $f2 (param f64) (result f64)))
  (import "s7_ic04_host" "f3" (func $f3 (param f64) (result f64)))
  (import "s7_ic04_host" "f4" (func $f4 (param f64) (result f64)))
  (func (export "_start")
    f64.const 454.0
    call $f1
    drop
    f64.const 421.0
    call $f3
    drop
    f64.const 192.0
    call $f2
    drop
    f64.const 147.0
    call $f0
    drop
    f64.const 461.0
    call $f4
    drop
  )
)
