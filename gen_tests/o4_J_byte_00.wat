(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_b_0
    call $app_rd_0
  )
  (func $r3_b_0
    i32.const 4104 i32.const 62 i32.store8)
  (func $app_rd_0 (export "app_rd_0")
    i32.const 4104 i32.load8_u drop)
)
