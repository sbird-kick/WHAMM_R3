(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main") call $app_grow_read)
  (func $app_grow_read (export "app_grow_read") i32.const 2 memory.grow drop i32.const 0 i32.load drop)
)