;; chain of nested if(result) each passing through the loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_dic drop)
  (func $r3_poke i32.const 4000 i32.const 12321 i32.store)
  (func $app_dic (export "app_dic") (result i32)
    (if (result i32) (i32.const 1)
      (then (if (result i32) (i32.const 1)
        (then (if (result i32) (i32.const 1)
          (then i32.const 4000 i32.load)
          (else i32.const 0)))
        (else i32.const 0)))
      (else i32.const 0))))
