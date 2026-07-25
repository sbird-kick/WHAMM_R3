(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w1_3
    call $r3_w2_3
    call $app_rd_3
  )
  (func $r3_w1_3
    i32.const 3224 i32.const 399223021 i32.store)
  (func $r3_w2_3
    i32.const 3224 i32.const 399223021 i32.store)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 3224 i32.load drop)
)
