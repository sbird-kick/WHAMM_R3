;; o3_d19_f32_nan_arith0x
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 14064 f32.const nan:0x400000 f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 14064 f32.load drop))
