(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_read)
  (func $r3_poke
    i32.const 8 i32.const 123 i32.store)
  (func $app_read (export "app_read")
    i32.const 8 i32.load drop))
