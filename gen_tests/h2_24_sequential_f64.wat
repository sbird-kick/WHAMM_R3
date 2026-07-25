;; Sequential f64 stores at consecutive addresses (8-byte spacing)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f64.const 0.25 f64.store
    i32.const 8 f64.const 1.25 f64.store
    i32.const 16 f64.const 2.25 f64.store
    i32.const 24 f64.const 3.25 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop
    i32.const 8 f64.load drop
    i32.const 16 f64.load drop
    i32.const 24 f64.load drop))
