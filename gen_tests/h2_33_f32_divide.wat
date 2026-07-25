;; F32 division: 5.0 / 2.0 = 2.5
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f32.const 5.0
    f32.const 2.0
    f32.div
    f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
