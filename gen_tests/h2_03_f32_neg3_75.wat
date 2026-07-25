;; F32: -3.75 exact binary representation
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 8 f32.const -3.75 f32.store
    call $work)
  (func $work (export "work")
    i32.const 8 f32.load drop))
