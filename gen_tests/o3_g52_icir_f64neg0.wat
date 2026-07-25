;; o3_g52: IC/IR host returns -0.0 f64
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret drop)
  (func $r3_ret (result f64)
    f64.const -0x0p+0))
