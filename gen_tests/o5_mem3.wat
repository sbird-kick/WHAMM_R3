(module
  (memory (export "memory") 1)
  (memory 1)
  (memory 1)
  (func $r3_main (export "_start") (export "main") call $r3_poke call $app_read)
  (func $r3_poke
    i32.const 8 i32.const 9505 i32.store 0
    i32.const 12 i32.const 9516 i32.store 1
    i32.const 16 i32.const 9527 i32.store 2
  )
  (func $app_read (export "app_read")
    i32.const 8 i32.load 0 drop
    i32.const 12 i32.load 1 drop
    i32.const 16 i32.load 2 drop
  )
)