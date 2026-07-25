(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_b_1
    call $app_rd_1
  )
  (func $r3_b_1
    i32.const 2072 i32.const 207 i32.store8)
  (func $app_rd_1 (export "app_rd_1")
    i32.const 2072 i32.load8_u drop)
)
