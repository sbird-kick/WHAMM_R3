;; F64 subtraction: 8.75 - 3.5 = 5.25
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f64.const 8.75
    f64.const 3.5
    f64.sub
    f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
