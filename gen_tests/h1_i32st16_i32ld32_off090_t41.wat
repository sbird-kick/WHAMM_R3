;; h1_i32st16_i32ld32_off090_t41: load divergence with 16-bit store, 32-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 90
    i32.const 50169
    i32.store16)
  (func $app_read (export "app_read")
    i32.const 91
    i32.load
    drop))
