;; h6_fill_len1024_08: memory.fill with length 1024
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100
    i32.const 37
    i32.const 1024
    memory.fill
    i32.const 100 i32.load drop))
