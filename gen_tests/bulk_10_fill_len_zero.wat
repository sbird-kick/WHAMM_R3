;; bulk_10_fill_len_zero: memory.fill with length 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0x99 i32.const 100 i32.const 0 memory.fill
    i32.const 100 i32.load drop))
