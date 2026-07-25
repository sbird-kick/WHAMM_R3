;; o3_b06_store8_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 54552 i64.const 0x8000000000000080 i64.store8
    call $rd)
  (func $rd (export "rd")
    i32.const 54552 i64.load8_u drop))
