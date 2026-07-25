;; Sequential f32 stores at consecutive addresses
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f32.const 0.5 f32.store
    i32.const 4 f32.const 1.5 f32.store
    i32.const 8 f32.const 2.5 f32.store
    i32.const 12 f32.const 3.5 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop
    i32.const 4 f32.load drop
    i32.const 8 f32.load drop
    i32.const 12 f32.load drop))
