;; h6_fill_len0_01: memory.fill with length 0
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 392
    i32.const 173
    i32.const 0
    memory.fill
    i32.const 392 i32.load drop))
