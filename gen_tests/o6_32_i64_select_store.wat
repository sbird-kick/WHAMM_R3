;; untyped select on i64 loads feeding an i64 store
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_i64s)
  (func $r3_poke
    i32.const 3600 i64.const 123456789 i64.store
    i32.const 3608 i64.const 987654321 i64.store)
  (func $app_i64s (export "app_i64s")
    i32.const 3616
    i32.const 3600 i64.load
    i32.const 3608 i64.load
    i32.const 1
    select
    i64.store
    i32.const 3616 i64.load drop))
