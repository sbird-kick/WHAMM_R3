(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_1
    call $app_rd_1
  )
  (func $r3_ov_1
    i32.const 30100 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 30101 i32.const 142 i32.store8)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 30100 i32.load drop)
)
