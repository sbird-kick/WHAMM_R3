;; multivalue function returning 2 values (res0 = LAST result)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_pair
    i32.add drop)
  (func $r3_poke
    i32.const 480 i32.const 41 i32.store
    i32.const 488 i32.const 42 i32.store)
  (func $app_pair (export "app_pair") (result i32 i32)
    i32.const 480 i32.load
    i32.const 488 i32.load))
