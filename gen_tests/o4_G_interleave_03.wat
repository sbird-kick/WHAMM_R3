(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_3
    call $r3_w_3
    call $app_a_3
    call $app_b_3
  )
  (func $r3_w_3
    i32.const 30636 i32.const 179661963 i32.store)
  (func $app_a_3 (export "app_a_3")
    i32.const 30636 i32.load drop)
  (func $app_b_3 (export "app_b_3")
    i32.const 29216 i32.load drop)
)
