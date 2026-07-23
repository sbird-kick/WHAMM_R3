;; bulk_12_init_len_zero: memory.init with length 0
(module
  (memory (export "mem") 1)
  (data $seg "\aa\bb\cc")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 0 memory.init $seg
    i32.const 100 i32.load drop))
