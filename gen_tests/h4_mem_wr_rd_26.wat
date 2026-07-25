(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_read)
  (func $r3_write
    i32.const 4 i32.const 260 i32.store)
  (func $app_read (export "app_read")
    i32.const 4 i32.load drop))
