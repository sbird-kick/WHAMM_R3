;; function returning THREE values from three loads (res0=LAST)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_three i32.add i32.add drop)
  (func $r3_poke
    i32.const 3200 i32.const 100 i32.store
    i32.const 3208 i32.const 200 i32.store
    i32.const 3216 i32.const 300 i32.store)
  (func $app_three (export "app_three") (result i32 i32 i32)
    i32.const 3200 i32.load
    i32.const 3208 i32.load
    i32.const 3216 i32.load))
