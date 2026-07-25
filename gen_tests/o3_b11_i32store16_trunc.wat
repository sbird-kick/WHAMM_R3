;; o3_b11_i32store16_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 34672 i32.const 0x1234fffe i32.store16
    call $rd)
  (func $rd (export "rd")
    i32.const 34672 i32.load16_s drop))
