;; Mixed f32 and i32 stores and loads
;; Expected: L events at addresses with type mismatch
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 42 i32.store
    i32.const 4 f32.const 1.5 f32.store
    i32.const 8 i32.const 99 i32.store
    i32.const 12 f32.const -2.25 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load drop
    i32.const 4 f32.load drop
    i32.const 8 i32.load drop
    i32.const 12 f32.load drop))
