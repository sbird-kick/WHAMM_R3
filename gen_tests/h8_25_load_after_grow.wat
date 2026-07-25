;; h8_25_load_after_grow: Load from newly grown memory
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_expand)
  (func $app_expand (export "app_expand")
    i32.const 3 memory.grow drop
    i32.const 65536 i32.const 99 i32.store
    i32.const 65536 i32.load drop))
