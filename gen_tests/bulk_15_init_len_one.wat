;; bulk_15_init_len_one: memory.init with length 1
(module
  (memory (export "mem") 1)
  (data $seg "\ab\cd\ef")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 1 i32.const 1 memory.init $seg
    i32.const 100 i32.load8_u drop))
