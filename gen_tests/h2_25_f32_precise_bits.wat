;; F32 with specific bit pattern (i32 0x41200000 = 10.0 in f32)
;; Host writes this pattern as i32, app reads as f32
;; Expected: L event (different values in shadow)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 0x41200000 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
