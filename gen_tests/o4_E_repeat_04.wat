(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_4
    call $app_rd_4
  )
  (func $r3_w_4
    i32.const 37208 i32.const 1041088948 i32.store)
  (func $app_rd_4 (export "app_rd_4")
    i32.const 37208 i32.load drop
    i32.const 37208 i32.load drop
    i32.const 37208 i32.load drop
    i32.const 37208 i32.load drop)
)
