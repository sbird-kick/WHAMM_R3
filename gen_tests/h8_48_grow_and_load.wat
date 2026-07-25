;; h8_48_grow_and_load: Grow then load from new region
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_growload)
  (func $app_growload (export "app_growload")
    i32.const 4 memory.grow drop
    i32.const 131072 i32.const 888 i32.store
    i32.const 131072 i32.load drop))
