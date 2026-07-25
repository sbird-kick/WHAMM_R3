;; h6_fill_len512_07: memory.fill with length 512
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100
    i32.const 30
    i32.const 512
    memory.fill
    i32.const 100 i32.load drop))
