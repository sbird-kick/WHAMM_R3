(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_3
    call $app_rd_3
  )
  (func $r3_ov_3
    i32.const 18800 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 18801 i32.const 23 i32.store8)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 18800 i32.load drop)
)
