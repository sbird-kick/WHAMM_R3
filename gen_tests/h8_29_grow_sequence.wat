;; h8_29_grow_sequence: Multiple grows in sequence
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_multi_grow)
  (func $app_multi_grow (export "app_multi_grow")
    i32.const 1 memory.grow drop
    i32.const 1 memory.grow drop
    i32.const 1 memory.grow drop))
