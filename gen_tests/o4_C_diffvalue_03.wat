(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_3
    call $r3_diff_3
    call $app_rd_3
  )
  (func $app_pre_3 (export "app_pre_3")
    i32.const 36472 i32.const 1519603381 i32.store)
  (func $r3_diff_3
    i32.const 36472 i32.const 986788324 i32.store)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 36472 i32.load drop)
)
