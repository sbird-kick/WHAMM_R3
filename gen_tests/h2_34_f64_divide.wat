;; F64 division: 7.5 / 3.0 = 2.5
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f64.const 7.5
    f64.const 3.0
    f64.div
    f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
