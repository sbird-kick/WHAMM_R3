;; h6_copy_overlap_fwd_16: forward overlapping copy
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 10 i32.const 0x55 i32.store
    i32.const 20
    i32.const 10
    i32.const 20
    memory.copy
    i32.const 20 i32.load drop))
