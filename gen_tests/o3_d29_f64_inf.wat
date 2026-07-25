;; o3_d29_f64_inf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 30304 f64.const inf f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 30304 f64.load drop))
