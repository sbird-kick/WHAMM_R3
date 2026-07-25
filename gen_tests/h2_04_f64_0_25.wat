;; F64: 0.25 exact binary representation
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f64.const 0.25 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
