;; memory.grow inside an app fn called by host, load old + new page
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_g2 drop)
  (func $r3_poke
    i32.const 200 i32.const 31 i32.store
    i32.const 208 i32.const 32 i32.store)
  (func $app_g2 (export "app_g2") (result i32)
    i32.const 200 i32.load
    (block $b
      i32.const 2 memory.grow drop)
    i32.const 208 i32.load
    i32.add))
