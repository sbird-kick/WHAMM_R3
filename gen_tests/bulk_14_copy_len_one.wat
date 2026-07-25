;; bulk_14_copy_len_one: memory.copy with length 1
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\ee")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 1 memory.copy
    i32.const 100 i32.load8_u drop))
