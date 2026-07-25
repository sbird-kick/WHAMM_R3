;; F32: -0.0 has different bit pattern from 0.0
;; Expected: EC event (no divergence, same value)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 12 f32.const -0.0 f32.store
    call $work)
  (func $work (export "work")
    i32.const 12 f32.load drop))
