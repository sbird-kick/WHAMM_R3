(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_zero_2
    call $app_rd_2
  )
  (func $r3_zero_2
    i32.const 46964 i32.const 0 i32.store)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 46964 i32.load drop)
)
