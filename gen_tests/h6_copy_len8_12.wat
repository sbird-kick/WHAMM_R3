;; h6_copy_len8_12: memory.copy with length 8
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 244 i32.const 0x11 i32.store
    i32.const 344
    i32.const 244
    i32.const 8
    memory.copy
    i32.const 344 i32.load drop))
