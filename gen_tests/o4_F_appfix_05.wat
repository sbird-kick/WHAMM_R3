(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_5
    call $app_fix_5
  )
  (func $r3_w_5
    i32.const 12620 i32.const 1602691718 i32.store)
  (func $app_fix_5 (export "app_fix_5")
    i32.const 12620 i32.const 1978887057 i32.store
    i32.const 12620 i32.load drop)
)
