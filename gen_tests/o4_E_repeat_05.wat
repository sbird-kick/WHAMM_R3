(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_5
    call $app_rd_5
  )
  (func $r3_w_5
    i32.const 28280 i32.const 1233931697 i32.store)
  (func $app_rd_5 (export "app_rd_5")
    i32.const 28280 i32.load drop
    i32.const 28280 i32.load drop
    i32.const 28280 i32.load drop)
)
