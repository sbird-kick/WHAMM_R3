(module
  (memory (export "memory") 1)
  (memory 1)
  (func $r3_main (export "_start") (export "main") call $r3_grow call $app_read)
  (func $r3_grow i32.const 1 memory.grow 1 drop)
  (func $app_read (export "app_read") i32.const 0 i32.load 1 drop)
)