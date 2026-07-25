(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w1_2
    call $r3_w2_2
    call $app_rd_2
  )
  (func $r3_w1_2
    i32.const 8656 i32.const 361919634 i32.store)
  (func $r3_w2_2
    i32.const 8656 i32.const 361919634 i32.store)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 8656 i32.load drop)
)
