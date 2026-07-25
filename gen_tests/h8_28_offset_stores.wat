;; h8_28_offset_stores: Different offset stores
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 10 i32.store
    i32.const 16 i32.const 20 i32.store
    i32.const 32 i32.const 30 i32.store
    call $app_check_offsets)
  (func $app_check_offsets (export "app_check_offsets")
    i32.const 0 i32.load drop
    i32.const 16 i32.load drop
    i32.const 32 i32.load drop))
