;; single load buried 10 blocks deep, each producing a result
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_d10 drop)
  (func $r3_poke i32.const 2000 i32.const 96060 i32.store)
  (func $app_d10 (export "app_d10") (result i32)
    (block (result i32)(block (result i32)(block (result i32)(block (result i32)
    (block (result i32)(block (result i32)(block (result i32)(block (result i32)
    (block (result i32)(block (result i32)
      i32.const 2000 i32.load
    ))))))))))))
