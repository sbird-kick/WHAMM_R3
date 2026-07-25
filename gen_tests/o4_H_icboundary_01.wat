(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_1
  )
  (func $r3_h_1
    i32.const 40296 i32.const 1084266939 i32.store)
  (func $app_drv_1 (export "app_drv_1")
    i32.const 40296 i32.load drop
    call $r3_h_1
    i32.const 40296 i32.load drop)
)
