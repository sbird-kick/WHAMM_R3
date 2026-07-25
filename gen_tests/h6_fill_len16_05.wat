;; h6_fill_len16_05: memory.fill with length 16
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 111
    i32.const 75
    i32.const 16
    memory.fill
    i32.const 111 i32.load drop))
