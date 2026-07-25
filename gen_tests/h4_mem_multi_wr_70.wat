(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_w1
    call $r3_w2
    call $app_verify)
  (func $r3_w1
    i32.const 0 i32.const 11 i32.store)
  (func $r3_w2
    i32.const 0 i32.const 22 i32.store)
  (func $app_verify (export "app_verify")
    i32.const 0 i32.load drop
    i32.const 0 i32.load drop))
