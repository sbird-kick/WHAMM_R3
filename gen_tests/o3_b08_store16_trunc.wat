;; o3_b08_store16_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 35400 i64.const 0x123456789abc8000 i64.store16
    call $rd)
  (func $rd (export "rd")
    i32.const 35400 i64.load16_u drop))
