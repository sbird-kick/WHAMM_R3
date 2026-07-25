;; h1_i32st16_i32ld32_off146_t17: load divergence with 16-bit store, 32-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 146
    i32.const 45785
    i32.store16)
  (func $app_read (export "app_read")
    i32.const 147
    i32.load
    drop))
