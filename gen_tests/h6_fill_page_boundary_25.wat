;; h6_fill_page_boundary_25: fill near page boundary
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 65520
    i32.const 0xEE
    i32.const 8
    memory.fill
    i32.const 65520 i32.load drop))
