(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_5
    call $r3_w_5
    call $app_a_5
    call $app_b_5
  )
  (func $r3_w_5
    i32.const 25888 i32.const 1245162973 i32.store)
  (func $app_a_5 (export "app_a_5")
    i32.const 25888 i32.load drop)
  (func $app_b_5 (export "app_b_5")
    i32.const 7316 i32.load drop)
)
