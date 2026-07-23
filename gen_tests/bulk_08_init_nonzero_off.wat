;; bulk_08_init_nonzero_off: memory.init with nonzero source offset
(module
  (memory (export "mem") 1)
  (data $seg "\00\11\22\33\44\55")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 2 i32.const 2 memory.init $seg
    i32.const 100 i32.load8_u drop))
