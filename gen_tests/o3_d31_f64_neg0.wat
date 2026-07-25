;; o3_d31_f64_neg0
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 11152 f64.const -0x0p+0 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 11152 f64.load drop))
