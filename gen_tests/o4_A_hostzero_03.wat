(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_zero_3
    call $app_rd_3
  )
  (func $r3_zero_3
    i32.const 9032 i32.const 0 i32.const 8 memory.fill)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 9032 i32.load drop)
)
