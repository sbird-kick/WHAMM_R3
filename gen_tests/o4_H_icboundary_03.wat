(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_3
  )
  (func $r3_h_3
    i32.const 44044 i32.const 320079206 i32.store)
  (func $app_drv_3 (export "app_drv_3")
    i32.const 44044 i32.load drop
    call $r3_h_3
    i32.const 44044 i32.load drop)
)
