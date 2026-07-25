;; multivalue block returns 2 values, both from loads
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mv drop)
  (func $r3_poke
    i32.const 400 i32.const 7 i32.store
    i32.const 408 i32.const 8 i32.store)
  (func $app_mv (export "app_mv") (result i32)
    (block $b (result i32 i32)
      i32.const 400 i32.load
      i32.const 408 i32.load)
    i32.add))
