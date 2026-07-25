;; h6_fill_len2_03: memory.fill with length 2
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 280
    i32.const 205
    i32.const 2
    memory.fill
    i32.const 280 i32.load drop))
