;; F64 with specific bit pattern (i64 0x4024000000000000 = 10.0 in f64)
;; Host writes this pattern as i64, app reads as f64
;; Expected: L event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i64.const 0x4024000000000000 i64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
