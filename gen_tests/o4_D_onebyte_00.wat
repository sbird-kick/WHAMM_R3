(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_0
    call $app_rd_0
  )
  (func $r3_ov_0
    i32.const 53536 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 53537 i32.const 223 i32.store8)
  (func $app_rd_0 (export "app_rd_0")
    i32.const 53536 i32.load drop)
)
