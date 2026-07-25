;; h1_i32st16_i32ld32_off118_t29: load divergence with 16-bit store, 32-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 118
    i32.const 6985
    i32.store16)
  (func $app_read (export "app_read")
    i32.const 119
    i32.load
    drop))
