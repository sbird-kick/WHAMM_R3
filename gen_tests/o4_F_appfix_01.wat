(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_1
    call $app_fix_1
  )
  (func $r3_w_1
    i32.const 3552 i32.const 1737823449 i32.store)
  (func $app_fix_1 (export "app_fix_1")
    i32.const 3552 i32.const 322820243 i32.store
    i32.const 3552 i32.load drop)
)
