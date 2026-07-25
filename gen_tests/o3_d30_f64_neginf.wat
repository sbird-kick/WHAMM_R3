;; o3_d30_f64_neginf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 48728 f64.const -inf f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 48728 f64.load drop))
