;; F32: 16.5 exact binary
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 20 f32.const 16.5 f32.store
    call $work)
  (func $work (export "work")
    i32.const 20 f32.load drop))
