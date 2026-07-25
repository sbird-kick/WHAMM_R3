;; o3_a02_i64_max_mem
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 36856 i64.const 0x7fffffffffffffff i64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 36856 i64.load drop))
