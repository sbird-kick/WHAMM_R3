(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_4
    call $r3_diff_4
    call $app_rd_4
  )
  (func $app_pre_4 (export "app_pre_4")
    i32.const 18232 i32.const 1220867997 i32.store)
  (func $r3_diff_4
    i32.const 18232 i32.const 491278519 i32.store)
  (func $app_rd_4 (export "app_rd_4")
    i32.const 18232 i32.load drop)
)
