(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_b_0
    call $r3_w_0
    call $app_a_0
    call $app_b_0
  )
  (func $r3_w_0
    i32.const 49356 i32.const 1638515017 i32.store)
  (func $app_a_0 (export "app_a_0")
    i32.const 49356 i32.load drop)
  (func $app_b_0 (export "app_b_0")
    i32.const 1816 i32.load drop)
)
