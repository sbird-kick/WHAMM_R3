;; bulk_22_copy_self: Copy where source == destination
(module
  (memory (export "mem") 1)
  (data (i32.const 100) "\12\34\56\78")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 100 i32.const 4 memory.copy
    i32.const 100 i32.load drop))
