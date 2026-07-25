;; o3_f42_ec_f32inf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    f32.const inf
    call $take)
  (func $take (export "take") (param f32)
    nop))
