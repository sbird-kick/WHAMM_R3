;; h8_22_multi_loads: Multiple loads from host-modified memory
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 11 i32.store
    i32.const 4 i32.const 22 i32.store
    i32.const 8 i32.const 33 i32.store
    call $app_read_all)
  (func $app_read_all (export "app_read_all")
    i32.const 0 i32.load drop
    i32.const 4 i32.load drop
    i32.const 8 i32.load drop))
