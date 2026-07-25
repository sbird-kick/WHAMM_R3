(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_0
    call $app_rd_0
  )
  (func $r3_w_0
    i32.const 21516 i32.const 617725172 i32.store)
  (func $app_rd_0 (export "app_rd_0")
    i32.const 21516 i32.load drop
    i32.const 21516 i32.load drop
    i32.const 21516 i32.load drop
    i32.const 21516 i32.load drop
    i32.const 21516 i32.load drop)
)
