;; o3_g46_icir_f64nan
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret
    drop)
  (func $r3_ret (result f64)
    f64.const nan))
