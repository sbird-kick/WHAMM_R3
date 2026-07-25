;; typed select feeding a store, operands loaded
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_tsel)
  (func $r3_poke
    i32.const 720 i64.const 88 i64.store
    i32.const 728 i64.const 99 i64.store)
  (func $app_tsel (export "app_tsel")
    i32.const 736
    i32.const 720 i64.load
    i32.const 728 i64.load
    i32.const 0
    (select (result i64))
    i64.store
    i32.const 736 i64.load drop))
