;; EC parameter recording with multiple mixed parameters
;; Expected events: EC with args for i32, i64, f32, f64
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 10
    i64.const 20
    f32.const 1.5
    f64.const 2.5
    call $take_mixed)
  (func $take_mixed (export "take_mixed") (param i32 i64 f32 f64)
    ))
