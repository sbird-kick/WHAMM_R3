(module
  (memory (export "memory") 1 1)
  (func $r3_main (export "_start") (export "main") call $r3_grow call $app_read)
  (func $r3_grow i32.const 5 memory.grow drop)
  (func $app_read (export "app_read") i32.const 0 i32.load drop)
)