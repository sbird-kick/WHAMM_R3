(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_drv_2
  )
  (func $r3_h_2
    i32.const 31952 i32.const 1463755039 i32.store)
  (func $app_drv_2 (export "app_drv_2")
    i32.const 31952 i32.load drop
    call $r3_h_2
    i32.const 31952 i32.load drop)
)
