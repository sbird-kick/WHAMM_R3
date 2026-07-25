;; h6_copy_len1_10: memory.copy with length 1
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 220 i32.const 0x11 i32.store
    i32.const 320
    i32.const 220
    i32.const 1
    memory.copy
    i32.const 320 i32.load drop))
