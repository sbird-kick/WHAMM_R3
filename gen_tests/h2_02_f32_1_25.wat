;; F32: 1.25 exact binary representation
;; Offset 4 from seed: 2207 % 256 = 175, offset 4 chosen
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 4 f32.const 1.25 f32.store
    call $work)
  (func $work (export "work")
    i32.const 4 f32.load drop))
