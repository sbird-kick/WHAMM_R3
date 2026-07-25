(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_4
    call $app_fix_4
  )
  (func $r3_w_4
    i32.const 50560 i32.const 802005912 i32.store)
  (func $app_fix_4 (export "app_fix_4")
    i32.const 50560 i32.const 1951795628 i32.store
    i32.const 50560 i32.load drop)
)
