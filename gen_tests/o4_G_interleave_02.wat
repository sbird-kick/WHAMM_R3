(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_2
    call $r3_w_2
    call $app_a_2
    call $app_b_2
  )
  (func $r3_w_2
    i32.const 12284 i32.const 2015631399 i32.store)
  (func $app_a_2 (export "app_a_2")
    i32.const 12284 i32.load drop)
  (func $app_b_2 (export "app_b_2")
    i32.const 53892 i32.load drop)
)
