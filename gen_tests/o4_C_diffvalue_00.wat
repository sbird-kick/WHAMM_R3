(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_pre_0
    call $r3_diff_0
    call $app_rd_0
  )
  (func $app_pre_0 (export "app_pre_0")
    i32.const 6788 i32.const 2011878602 i32.store)
  (func $r3_diff_0
    i32.const 6788 i32.const 598850408 i32.store)
  (func $app_rd_0 (export "app_rd_0")
    i32.const 6788 i32.load drop)
)
