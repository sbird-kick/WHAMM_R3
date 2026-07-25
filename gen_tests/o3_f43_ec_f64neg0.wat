;; o3_f43_ec_f64neg0
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    f64.const -0x0p+0
    call $take)
  (func $take (export "take") (param f64)
    nop))
