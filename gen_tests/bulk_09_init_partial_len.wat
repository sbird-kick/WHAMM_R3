;; bulk_09_init_partial_len: memory.init with partial length
(module
  (memory (export "mem") 1)
  (data $seg "\aa\bb\cc\dd\ee\ff")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 1 i32.const 3 memory.init $seg
    i32.const 100 i32.load drop))
