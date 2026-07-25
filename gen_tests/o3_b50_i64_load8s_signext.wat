;; o3_b50: store8 0xFF then load8_s sign-extends to i64 -1
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 43632 i64.const 0xff i64.store8
    call $rd)
  (func $rd (export "rd")
    i32.const 43632 i64.load8_s drop))
