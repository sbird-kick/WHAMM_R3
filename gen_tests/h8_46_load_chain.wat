;; h8_46_load_chain: Chain of loads
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 10 i32.store
    i32.const 8 i32.const 20 i32.store
    i32.const 16 i32.const 30 i32.store
    i32.const 24 i32.const 40 i32.store
    call $app_loadchain)
  (func $app_loadchain (export "app_loadchain")
    i32.const 0 i32.load drop
    i32.const 8 i32.load drop
    i32.const 16 i32.load drop
    i32.const 24 i32.load drop))
