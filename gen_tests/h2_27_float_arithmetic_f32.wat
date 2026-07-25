;; Float arithmetic: f32 operations leading to a load
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    f32.const 2.5
    f32.const 1.5
    f32.add
    f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
