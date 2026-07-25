(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_6
    call $r3_diff_6
    call $app_rd_6
  )
  (func $app_pre_6 (export "app_pre_6")
    i32.const 21292 i32.const 1626880739 i32.store)
  (func $r3_diff_6
    i32.const 21292 i32.const 739213203 i32.store)
  (func $app_rd_6 (export "app_rd_6")
    i32.const 21292 i32.load drop)
)
