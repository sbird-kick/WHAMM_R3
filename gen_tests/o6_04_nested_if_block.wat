;; nested if inside block with result, load in innermost
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_nif drop)
  (func $r3_poke i32.const 320 i32.const 9999 i32.store)
  (func $app_nif (export "app_nif") (result i32)
    (block $b (result i32)
      (if (result i32) (i32.const 1)
        (then
          (if (result i32) (i32.const 1)
            (then i32.const 320 i32.load)
            (else i32.const 0)))
        (else i32.const 0)))))
