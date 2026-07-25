;; Host-sim writes i32 0x3f800000 (1.0 as f32 bits), app reads as f32
;; Creates load divergence
;; Expected: L event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 0x3f800000 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
