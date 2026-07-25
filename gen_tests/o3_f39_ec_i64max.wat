;; o3_f39_ec_i64max
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i64.const 0x7fffffffffffffff
    call $take)
  (func $take (export "take") (param i64)
    nop))
