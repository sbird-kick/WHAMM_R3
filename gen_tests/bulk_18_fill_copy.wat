;; bulk_18_fill_copy: Real code fills then copies the filled region
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0xDD i32.const 100 i32.const 4 memory.fill
    i32.const 200 i32.const 100 i32.const 4 memory.copy
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop))
