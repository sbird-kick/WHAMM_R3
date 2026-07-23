;; bulk_13_fill_len_one: memory.fill with length 1
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0xCC i32.const 100 i32.const 1 memory.fill
    i32.const 100 i32.load8_u drop))
