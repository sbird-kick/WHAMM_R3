(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_3
    call $r3_same_3
    call $app_rd_3
  )
  (func $app_pre_3 (export "app_pre_3")
    i32.const 28344 i32.const 1609730674 i32.store)
  (func $r3_same_3
    i32.const 28344 i32.const 1609730674 i32.store)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 28344 i32.load drop)
)
