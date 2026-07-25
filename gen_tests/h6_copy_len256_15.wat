;; h6_copy_len256_15: memory.copy with length 256
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_copy)
  (func $app_copy (export "copy")
    i32.const 512
    i32.const 100
    i32.const 256
    memory.copy
    i32.const 512 i32.load drop))
