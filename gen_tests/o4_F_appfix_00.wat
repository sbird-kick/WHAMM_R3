(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w_0
    call $app_fix_0
  )
  (func $r3_w_0
    i32.const 42428 i32.const 1464731180 i32.store)
  (func $app_fix_0 (export "app_fix_0")
    i32.const 42428 i32.const 623690135 i32.store
    i32.const 42428 i32.load drop)
)
