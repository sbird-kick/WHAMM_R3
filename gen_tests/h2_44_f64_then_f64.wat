;; Two f64 stores at same address (overwrite)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f64.const 3.5 f64.store
    i32.const 0 f64.const 4.75 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop))
