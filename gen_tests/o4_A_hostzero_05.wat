(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_zero_5
    call $app_rd_5
  )
  (func $r3_zero_5
    i32.const 748 i32.const 0 i32.const 5 memory.fill)
  (func $app_rd_5 (export "app_rd_5")
    i32.const 748 i32.load drop)
)
