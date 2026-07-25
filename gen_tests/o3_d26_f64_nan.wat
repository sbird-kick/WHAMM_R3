;; o3_d26_f64_nan
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 31032 f64.const nan f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 31032 f64.load drop))
