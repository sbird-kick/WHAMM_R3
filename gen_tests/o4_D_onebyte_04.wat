(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_4
    call $app_rd_4
  )
  (func $r3_ov_4
    i32.const 312 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 313 i32.const 55 i32.store8)
  (func $app_rd_4 (export "app_rd_4")
    i32.const 312 i32.load drop)
)
