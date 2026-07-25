;; o3_b10_i32store8_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 16248 i32.const 0xffffff80 i32.store8
    call $rd)
  (func $rd (export "rd")
    i32.const 16248 i32.load8_u drop))
