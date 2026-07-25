(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_0
  )
  (func $r3_h_0
    i32.const 51724 i32.const 244048655 i32.store)
  (func $app_drv_0 (export "app_drv_0")
    i32.const 51724 i32.load drop
    call $r3_h_0
    i32.const 51724 i32.load drop)
)
