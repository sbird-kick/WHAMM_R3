;; h6_copy_len0_28: copy with length 0
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 50 i32.const 0 memory.copy
    i32.const 100 i32.load drop))
