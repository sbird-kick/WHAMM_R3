;; Multiple f64 stores at different addresses
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f64.const 0.25 f64.store
    i32.const 8 f64.const -1.5 f64.store
    i32.const 16 f64.const 3.125 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop
    i32.const 8 f64.load drop
    i32.const 16 f64.load drop))
