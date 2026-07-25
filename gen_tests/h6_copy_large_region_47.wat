;; h6_copy_large_region_47: copy 1KB region
(module
  (memory (export "memory") 3)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 1000
    i32.const 100
    i32.const 1024
    memory.copy
    i32.const 1000 i32.load drop))
