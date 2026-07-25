(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_b_2
    call $app_rd_2
  )
  (func $r3_b_2
    i32.const 23264 i32.const 57 i32.store8)
  (func $app_rd_2 (export "app_rd_2")
    i32.const 23264 i32.load8_u drop)
)
