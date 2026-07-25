;; Host stores f32, app loads as i64 (type mismatch)
;; Expected: L event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f32.const 3.14 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load drop))
