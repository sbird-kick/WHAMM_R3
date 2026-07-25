;; block with params: value pushed then block consumes, load inside
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_bp drop)
  (func $r3_poke i32.const 1360 i32.const 6060 i32.store)
  (func $app_bp (export "app_bp") (result i32)
    i32.const 100
    (block $b (param i32) (result i32)
      i32.const 1360 i32.load
      i32.add)))
