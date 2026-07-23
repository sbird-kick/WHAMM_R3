;; bulk_19_copy_fill: Copy a region, then fill it
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 4 memory.copy
    i32.const 0xFF i32.const 100 i32.const 4 memory.fill
    i32.const 100 i32.load drop))
