;; multivalue block yields two loads which become select operands
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_smv drop)
  (func $r3_poke
    i32.const 3440 i32.const 71 i32.store
    i32.const 3448 i32.const 72 i32.store)
  (func $app_smv (export "app_smv") (result i32)
    (block $b (result i32 i32)
      i32.const 3440 i32.load
      i32.const 3448 i32.load)
    i32.const 1
    select))
