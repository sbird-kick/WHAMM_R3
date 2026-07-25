;; br_if inside block(result) conditionally carries a loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_bic drop)
  (func $r3_poke i32.const 4080 i32.const 55055 i32.store)
  (func $app_bic (export "app_bic") (result i32)
    (block $b (result i32)
      i32.const 4080 i32.load
      i32.const 1
      br_if $b
      drop
      i32.const 0)))
