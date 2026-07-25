;; Complex f64 sequence with arithmetic
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f64.const 15.75
    f64.const 2.25
    f64.add
    f64.const 2.5
    f64.mul
    f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
