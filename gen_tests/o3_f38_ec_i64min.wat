;; o3_f38_ec_i64min
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i64.const 0x8000000000000000
    call $take)
  (func $take (export "take") (param i64)
    nop))
