;; bulk_01_fill_real_load: Real code fills then loads from same region
;; Expected events: none (shadow tracks the fill)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0xAA i32.const 100 i32.const 20 memory.fill
    i32.const 100 i32.load drop))
