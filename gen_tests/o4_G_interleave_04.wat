(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_4
    call $r3_w_4
    call $app_a_4
    call $app_b_4
  )
  (func $r3_w_4
    i32.const 51900 i32.const 1397158632 i32.store)
  (func $app_a_4 (export "app_a_4")
    i32.const 51900 i32.load drop)
  (func $app_b_4 (export "app_b_4")
    i32.const 18736 i32.load drop)
)
