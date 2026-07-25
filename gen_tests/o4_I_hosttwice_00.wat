(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w1_0
    call $r3_w2_0
    call $app_rd_0
  )
  (func $r3_w1_0
    i32.const 34028 i32.const 478501105 i32.store)
  (func $r3_w2_0
    i32.const 34028 i32.const 478501105 i32.store)
  (func $app_rd_0 (export "app_rd_0")
    i32.const 34028 i32.load drop)
)
