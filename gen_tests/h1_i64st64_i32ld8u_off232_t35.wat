;; h1_i64st64_i32ld8u_off232_t35: load divergence with 64-bit store, 8-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 232
    i64.const 81985529216486151
    i64.store)
  (func $app_read (export "app_read")
    i32.const 235
    i32.load8_u
    drop))
