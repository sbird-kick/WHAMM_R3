(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_1
    call $r3_diff_1
    call $app_rd_1
  )
  (func $app_pre_1 (export "app_pre_1")
    i32.const 36808 i32.const 773252611 i32.store)
  (func $r3_diff_1
    i32.const 36808 i32.const 171423843 i32.store)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 36808 i32.load drop)
)
