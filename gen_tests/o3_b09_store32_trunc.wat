;; o3_b09_store32_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 53824 i64.const 0x7fffffff80000000 i64.store32
    call $rd)
  (func $rd (export "rd")
    i32.const 53824 i64.load32_u drop))
