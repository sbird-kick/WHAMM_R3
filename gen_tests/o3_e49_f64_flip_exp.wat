;; o3_e49_f64_flip_exp: host overwrites flipping an exponent bit
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 25208 f64.const 0x1p+0 f64.store
    i32.const 25208 f64.const 0x1p+1 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 25208 f64.load drop))
