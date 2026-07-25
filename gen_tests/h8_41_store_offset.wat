;; h8_41_store_offset: Host store with various offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 12 i32.const 100 i32.store
    i32.const 16 i32.const 200 i32.store
    call $app_verify)
  (func $app_verify (export "app_verify")
    i32.const 12 i32.load drop
    i32.const 16 i32.load drop))
