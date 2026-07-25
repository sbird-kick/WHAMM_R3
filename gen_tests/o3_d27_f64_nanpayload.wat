;; o3_d27_f64_nanpayload
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 49456 f64.const nan:0x8000000000000 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 49456 f64.load drop))
