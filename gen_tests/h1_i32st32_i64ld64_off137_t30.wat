;; h1_i32st32_i64ld64_off137_t30: load divergence with 32-bit store, 64-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 137
    i32.const 3165791605
    i32.store)
  (func $app_read (export "app_read")
    i32.const 139
    i64.load
    drop))
