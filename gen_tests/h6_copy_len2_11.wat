;; h6_copy_len2_11: memory.copy with length 2
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 121 i32.const 0x11 i32.store
    i32.const 221
    i32.const 121
    i32.const 2
    memory.copy
    i32.const 221 i32.load drop))
