;; h6_fill_copy_fill_50: fill, copy, fill again
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 0x11 i32.const 32 memory.fill
    i32.const 200
    i32.const 100
    i32.const 32
    memory.copy
    i32.const 300 i32.const 0x22 i32.const 32 memory.fill
    i32.const 200 i32.load drop))
