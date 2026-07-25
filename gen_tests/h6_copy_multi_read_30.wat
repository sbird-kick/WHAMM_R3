;; h6_copy_multi_read_30: copy then multiple reads
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 50 i32.const 0x44 i32.store
    i32.const 100 i32.const 50 i32.const 16 memory.copy
    i32.const 100 i32.load drop
    i32.const 104 i32.load drop
    i32.const 108 i32.load drop))
