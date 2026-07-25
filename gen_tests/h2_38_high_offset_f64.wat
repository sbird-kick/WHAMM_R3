;; F64 store at higher memory offset (40)
;; Expected: EC event
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 40 f64.const -5.375 f64.store
    call $work)
  (func $work (export "work")
    i32.const 40 f64.load drop))
