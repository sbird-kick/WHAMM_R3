(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_5
    call $app_rd_5
  )
  (func $r3_ov_5
    i32.const 13188 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 13189 i32.const 180 i32.store8)
  (func $app_rd_5 (export "app_rd_5")
    i32.const 13188 i32.load drop)
)
