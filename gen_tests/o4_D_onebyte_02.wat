(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_ov_2
    call $app_rd_2
  )
  (func $r3_ov_2
    i32.const 43748 i32.const 0 i32.store            ;; shadow stays 0, no change
    i32.const 43749 i32.const 255 i32.store8)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 43748 i32.load drop)
)
