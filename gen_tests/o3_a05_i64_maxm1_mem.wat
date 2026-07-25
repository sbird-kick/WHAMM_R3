;; o3_a05_i64_maxm1_mem
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 36128 i64.const 0x7ffffffffffffffe i64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 36128 i64.load drop))
