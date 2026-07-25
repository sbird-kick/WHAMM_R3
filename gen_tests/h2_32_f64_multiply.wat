;; F64 multiplication: 3.5 * 2.5 = 8.75
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f64.const 3.5
    f64.const 2.5
    f64.mul
    f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
