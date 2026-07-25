;; h6_fill_page_cross_09: memory.fill crosses page boundary
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 65500
    i32.const 0xAB
    i32.const 100
    memory.fill
    i32.const 65500 i32.load drop))
