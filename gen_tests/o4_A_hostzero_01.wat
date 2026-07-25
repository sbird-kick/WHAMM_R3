(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_zero_1
    call $app_rd_1
  )
  (func $r3_zero_1
    i32.const 44252 i32.const 0 i32.const 3 memory.fill)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 44252 i32.load drop)
)
