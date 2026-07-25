(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_2
    call $r3_diff_2
    call $app_rd_2
  )
  (func $app_pre_2 (export "app_pre_2")
    i32.const 53900 i32.const 1918851853 i32.store)
  (func $r3_diff_2
    i32.const 53900 i32.const 1469647646 i32.store)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 53900 i32.load drop)
)
