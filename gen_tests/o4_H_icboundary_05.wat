(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_5
  )
  (func $r3_h_5
    i32.const 21984 i32.const 470488464 i32.store)
  (func $app_drv_5 (export "app_drv_5")
    i32.const 21984 i32.load drop
    call $r3_h_5
    i32.const 21984 i32.load drop)
)
