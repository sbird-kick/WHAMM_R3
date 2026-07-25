(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_7
    call $r3_diff_7
    call $app_rd_7
  )
  (func $app_pre_7 (export "app_pre_7")
    i32.const 384 i32.const 1201876310 i32.store)
  (func $r3_diff_7
    i32.const 384 i32.const 1604083200 i32.store)
  (func $app_rd_7 (export "app_rd_7")
    i32.const 384 i32.load drop)
)
