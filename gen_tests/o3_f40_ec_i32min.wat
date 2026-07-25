;; o3_f40_ec_i32min
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0x80000000
    call $take)
  (func $take (export "take") (param i32)
    nop))
