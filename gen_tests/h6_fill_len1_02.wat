;; h6_fill_len1_02: memory.fill with length 1
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 144
    i32.const 69
    i32.const 1
    memory.fill
    i32.const 144 i32.load drop))
