(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_zero_4
    call $app_rd_4
  )
  (func $r3_zero_4
    i32.const 47636 i32.const 0 i32.store)
  (func $app_rd_4 (export "app_rd_4")
    i32.const 47636 i32.load drop)
)
