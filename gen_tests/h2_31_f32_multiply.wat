;; F32 multiplication: 2.5 * 2.0 = 5.0
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f32.const 2.5
    f32.const 2.0
    f32.mul
    f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
