;; F32: 0.125 exact binary (1/8)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 16 f32.const 0.125 f32.store
    call $work)
  (func $work (export "work")
    i32.const 16 f32.load drop))
