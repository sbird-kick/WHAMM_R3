;; F64 store at unaligned offset (but still valid)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 3 f64.const 2.5 f64.store
    call $work)
  (func $work (export "work")
    i32.const 3 f64.load drop))
