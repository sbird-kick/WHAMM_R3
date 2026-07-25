;; o3_a01_i64_min_mem
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 18432 i64.const 0x8000000000000000 i64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 18432 i64.load drop))
