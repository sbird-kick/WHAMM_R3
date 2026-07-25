;; h6_copy_len16_13: memory.copy with length 16
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 224 i32.const 0x11 i32.store
    i32.const 324
    i32.const 224
    i32.const 16
    memory.copy
    i32.const 324 i32.load drop))
