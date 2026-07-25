;; Host stores f64, app loads as i32 (type mismatch)
;; Expected: L event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f64.const 2.71 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load drop))
