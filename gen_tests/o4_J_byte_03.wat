(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_b_3
    call $app_rd_3
  )
  (func $r3_b_3
    i32.const 50528 i32.const 135 i32.store8)
  (func $app_rd_3 (export "app_rd_3")
    i32.const 50528 i32.load8_u drop)
)
