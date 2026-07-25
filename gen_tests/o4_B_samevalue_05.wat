(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_5
    call $r3_same_5
    call $app_rd_5
  )
  (func $app_pre_5 (export "app_pre_5")
    i32.const 40092 i32.const 507249978 i32.store)
  (func $r3_same_5
    i32.const 40092 i32.const 507249978 i32.store)
  (func $app_rd_5 (export "app_rd_5")
    i32.const 40092 i32.load drop)
)
