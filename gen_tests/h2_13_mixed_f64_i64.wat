;; Mixed f64 and i64 stores and loads
;; Expected: L events at addresses with type mismatch
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i64.const 123456 i64.store
    i32.const 8 f64.const 1.75 f64.store
    i32.const 16 i64.const 789012 i64.store
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load drop
    i32.const 8 f64.load drop
    i32.const 16 i64.load drop))
