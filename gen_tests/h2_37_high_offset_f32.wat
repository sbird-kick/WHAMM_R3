;; F32 store at higher memory offset (32)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 32 f32.const 6.25 f32.store
    call $work)
  (func $work (export "work")
    i32.const 32 f32.load drop))
