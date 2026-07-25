;; h1_i32st32_i64ld64_off213_t34: load divergence with 32-bit store, 64-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 213
    i32.const 1251679621
    i32.store)
  (func $app_read (export "app_read")
    i32.const 215
    i64.load
    drop))
