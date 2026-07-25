;; h1_i32st8_i32ld16s_off051_t12: load divergence with 8-bit store, 16-bit load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 51
    i32.const 157
    i32.store8)
  (func $app_read (export "app_read")
    i32.const 51
    i32.load16_s
    drop))
