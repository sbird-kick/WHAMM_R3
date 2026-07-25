;; h6_copy_len32_14: memory.copy with length 32
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 63 i32.const 0x11 i32.store
    i32.const 163
    i32.const 63
    i32.const 32
    memory.copy
    i32.const 163 i32.load drop))
