(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_3
    call $app_fix_3
  )
  (func $r3_w_3
    i32.const 1992 i32.const 51774514 i32.store)
  (func $app_fix_3 (export "app_fix_3")
    i32.const 1992 i32.const 1761985395 i32.store
    i32.const 1992 i32.load drop)
)
