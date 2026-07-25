(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_2
    call $app_rd_2
  )
  (func $r3_w_2
    i32.const 55852 i32.const 1490971000 i32.store)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 55852 i32.load drop
    i32.const 55852 i32.load drop
    i32.const 55852 i32.load drop
    i32.const 55852 i32.load drop
    i32.const 55852 i32.load drop)
)
