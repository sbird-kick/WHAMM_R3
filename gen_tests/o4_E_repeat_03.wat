(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_3
    call $app_rd_3
  )
  (func $r3_w_3
    i32.const 20800 i32.const 898027792 i32.store)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 20800 i32.load drop
    i32.const 20800 i32.load drop
    i32.const 20800 i32.load drop)
)
