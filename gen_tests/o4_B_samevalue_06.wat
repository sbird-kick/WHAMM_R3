(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_6
    call $r3_same_6
    call $app_rd_6
  )
  (func $app_pre_6 (export "app_pre_6")
    i32.const 16876 i32.const 1140877548 i32.store)
  (func $r3_same_6
    i32.const 16876 i32.const 1140877548 i32.store)
  (func $app_rd_6 (export "app_rd_6")
    i32.const 16876 i32.load drop)
)
