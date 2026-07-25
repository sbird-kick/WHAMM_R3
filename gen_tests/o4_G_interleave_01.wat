(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_1
    call $r3_w_1
    call $app_a_1
    call $app_b_1
  )
  (func $r3_w_1
    i32.const 33816 i32.const 516888905 i32.store)
  (func $app_a_1 (export "app_a_1")
    i32.const 33816 i32.load drop)
  (func $app_b_1 (export "app_b_1")
    i32.const 45192 i32.load drop)
)
