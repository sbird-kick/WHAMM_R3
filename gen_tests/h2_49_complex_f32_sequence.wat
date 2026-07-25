;; Complex f32 sequence with arithmetic
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f32.const 10.5
    f32.const 2.5
    f32.add
    f32.const 3.0
    f32.mul
    f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
