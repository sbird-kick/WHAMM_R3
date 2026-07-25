;; o3_b51: store32 0x80000000 then load32_s sign-extends
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 6056 i64.const 0x80000000 i64.store32
    call $rd)
  (func $rd (export "rd")
    i32.const 6056 i64.load32_s drop))
