;; bulk_04_copy_backward_overlap: Real code copies backward with overlap
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\01\02\03\04\05\06\07\08")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 1 i32.const 4 i32.const 4 memory.copy
    i32.const 1 i32.load drop))
