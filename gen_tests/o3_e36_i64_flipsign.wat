;; o3_e36_i64_flipsign
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 47272 i64.const 0x0000000000000001 i64.store
    i32.const 47272 i64.const 0x8000000000000001 i64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 47272 i64.load drop))
