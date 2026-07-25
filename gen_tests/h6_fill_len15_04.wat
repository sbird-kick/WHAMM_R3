;; h6_fill_len15_04: memory.fill with length 15
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 127
    i32.const 120
    i32.const 15
    memory.fill
    i32.const 127 i32.load drop))
