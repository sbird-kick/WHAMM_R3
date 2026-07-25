;; h6_two_copies_22: two consecutive copies
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 10 i32.const 0x55 i32.store
    i32.const 20 i32.const 10 i32.const 4 memory.copy
    i32.const 30 i32.const 20 i32.const 4 memory.copy
    i32.const 30 i32.load drop))
