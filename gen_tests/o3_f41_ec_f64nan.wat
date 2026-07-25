;; o3_f41_ec_f64nan
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    f64.const nan
    call $take)
  (func $take (export "take") (param f64)
    nop))
