;; o3_g45_icir_i64max
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret
    drop)
  (func $r3_ret (result i64)
    i64.const 0x7fffffffffffffff))
