;; h6_fill_len256_06: memory.fill with length 256
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100
    i32.const 0
    i32.const 256
    memory.fill
    i32.const 100 i32.load drop))
