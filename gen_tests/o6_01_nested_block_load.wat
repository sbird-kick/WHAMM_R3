;; L inside deeply nested blocks with block result values
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_nested
    drop)
  (func $r3_poke
    i32.const 96 i32.const 9606 i32.store)
  (func $app_nested (export "app_nested") (result i32)
    (block $b0 (result i32)
      (block $b1 (result i32)
        (block $b2 (result i32)
          i32.const 96 i32.load)
        i32.const 1 i32.add)
      i32.const 2 i32.add)))
