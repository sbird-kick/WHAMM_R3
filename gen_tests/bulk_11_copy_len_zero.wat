;; bulk_11_copy_len_zero: memory.copy with length 0
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\11\22\33\44")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 0 memory.copy
    i32.const 100 i32.load drop))
