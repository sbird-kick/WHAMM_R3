;; o3_e37_i32_flipmsb
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 9696 i32.const 0x00000042 i32.store
    i32.const 9696 i32.const 0x80000042 i32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 9696 i32.load drop))
