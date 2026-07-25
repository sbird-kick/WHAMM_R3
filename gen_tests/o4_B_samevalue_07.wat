(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_7
    call $r3_same_7
    call $app_rd_7
  )
  (func $app_pre_7 (export "app_pre_7")
    i32.const 46884 i32.const 2079122398 i32.store)
  (func $r3_same_7
    i32.const 46884 i32.const 2079122398 i32.store)
  (func $app_rd_7 (export "app_rd_7")
    i32.const 46884 i32.load drop)
)
