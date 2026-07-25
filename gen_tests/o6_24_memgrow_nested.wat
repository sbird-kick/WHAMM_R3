;; memory.grow (MG) inside nested block, then load from new page
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_grow drop)
  (func $r3_poke i32.const 100 i32.const 4242 i32.store)
  (func $app_grow (export "app_grow") (result i32)
    (block $b (result i32)
      i32.const 1 memory.grow drop
      i32.const 100 i32.load)))
