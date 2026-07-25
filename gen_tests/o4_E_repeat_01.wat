(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_1
    call $app_rd_1
  )
  (func $r3_w_1
    i32.const 19108 i32.const 1524483422 i32.store)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 19108 i32.load drop
    i32.const 19108 i32.load drop
    i32.const 19108 i32.load drop
    i32.const 19108 i32.load drop
    i32.const 19108 i32.load drop)
)
