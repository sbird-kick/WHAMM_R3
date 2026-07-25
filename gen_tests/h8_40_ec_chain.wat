;; h8_40_ec_chain: Chain of external calls from host
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_a)
  (func $app_a (export "app_a")
    call $app_b)
  (func $app_b (export "app_b")
    i32.const 0 drop))
