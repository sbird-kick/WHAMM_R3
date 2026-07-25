(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_1
    call $r3_same_1
    call $app_rd_1
  )
  (func $app_pre_1 (export "app_pre_1")
    i32.const 7620 i32.const 1575433706 i32.store)
  (func $r3_same_1
    i32.const 7620 i32.const 1575433706 i32.store)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 7620 i32.load drop)
)
