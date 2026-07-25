;; F32 subtraction: 5.5 - 2.25 = 3.25
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f32.const 5.5
    f32.const 2.25
    f32.sub
    f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
