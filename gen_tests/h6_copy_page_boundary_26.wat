;; h6_copy_page_boundary_26: copy near page boundary
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 65520 i32.const 0xDD i32.store
    i32.const 65528
    i32.const 65520
    i32.const 4
    memory.copy
    i32.const 65528 i32.load drop))
