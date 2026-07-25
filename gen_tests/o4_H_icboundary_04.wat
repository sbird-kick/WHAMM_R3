(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_4
  )
  (func $r3_h_4
    i32.const 32332 i32.const 848556707 i32.store)
  (func $app_drv_4 (export "app_drv_4")
    i32.const 32332 i32.load drop
    call $r3_h_4
    i32.const 32332 i32.load drop)
)
