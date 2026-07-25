;; o3_d33_f64_subnormal_max
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 48000 f64.const 0x0.fffffffffffffp-1022 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 48000 f64.load drop))
