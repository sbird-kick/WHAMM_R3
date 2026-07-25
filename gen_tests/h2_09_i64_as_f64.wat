;; Host-sim writes i64 0x3ff0000000000000 (1.0 as f64 bits), app reads as f64
;; Creates load divergence
;; Expected: L event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i64.const 0x3ff0000000000000 i64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
