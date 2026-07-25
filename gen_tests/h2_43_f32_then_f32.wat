;; Two f32 stores at same address (overwrite)
;; Expected: EC event (second read uses second value)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f32.const 1.5 f32.store
    i32.const 0 f32.const 2.75 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
