(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w1_1
    call $r3_w2_1
    call $app_rd_1
  )
  (func $r3_w1_1
    i32.const 27488 i32.const 2091533873 i32.store)
  (func $r3_w2_1
    i32.const 27488 i32.const 2091533873 i32.store)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 27488 i32.load drop)
)
