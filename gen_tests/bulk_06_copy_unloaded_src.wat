;; bulk_06_copy_unloaded_src: Copy from unloaded source (L on load)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0xBB i32.const 50 i32.const 4 memory.fill
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 50 i32.const 4 memory.copy
    i32.const 100 i32.load drop))
