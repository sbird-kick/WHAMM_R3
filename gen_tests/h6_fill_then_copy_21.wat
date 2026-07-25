;; h6_fill_then_copy_21: fill then copy
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 0x88 i32.const 64 memory.fill
    i32.const 200
    i32.const 100
    i32.const 64
    memory.copy
    i32.const 200 i32.load drop))
