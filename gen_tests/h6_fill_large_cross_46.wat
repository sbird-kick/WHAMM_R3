;; h6_fill_large_cross_46: large fill crossing pages
(module
  (memory (export "memory") 3)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 65400
    i32.const 0x77
    i32.const 400
    memory.fill
    i32.const 65400 i32.load drop))
