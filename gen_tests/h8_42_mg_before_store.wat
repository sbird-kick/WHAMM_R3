;; h8_42_mg_before_store: Grow memory then store
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow_store)
  (func $app_grow_store (export "app_grow_store")
    i32.const 2 memory.grow drop
    i32.const 65540 i32.const 555 i32.store))
