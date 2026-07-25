;; h8_35_l_i64: Load divergence with 64-bit value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i64.const 0x123456789ABCDEF0 i64.store
    call $app_read64)
  (func $app_read64 (export "app_read64")
    i32.const 0 i64.load drop))
