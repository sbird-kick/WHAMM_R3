(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_2
    call $r3_same_2
    call $app_rd_2
  )
  (func $app_pre_2 (export "app_pre_2")
    i32.const 53124 i32.const 2028191740 i32.store)
  (func $r3_same_2
    i32.const 53124 i32.const 2028191740 i32.store)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 53124 i32.load drop)
)
