;; h1_i32st32_i64ld64_off165_t18: load divergence with 32-bit store, 64-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 165
    i32.const 4063788229
    i32.store)
  (func $app_read (export "app_read")
    i32.const 167
    i64.load
    drop))
