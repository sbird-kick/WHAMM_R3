;; o3_d32_f64_subnormal_min
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 29576 f64.const 0x0.0000000000001p-1022 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 29576 f64.load drop))
