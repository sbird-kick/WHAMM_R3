(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_2
    call $app_fix_2
  )
  (func $r3_w_2
    i32.const 45580 i32.const 1561015349 i32.store)
  (func $app_fix_2 (export "app_fix_2")
    i32.const 45580 i32.const 1321927070 i32.store
    i32.const 45580 i32.load drop)
)
