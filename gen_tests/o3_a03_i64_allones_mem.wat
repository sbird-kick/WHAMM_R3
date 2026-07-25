;; o3_a03_i64_allones_mem
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 55280 i64.const 0xffffffffffffffff i64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 55280 i64.load drop))
