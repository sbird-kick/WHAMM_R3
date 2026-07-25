;; o3_d28_f64_negnan
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 11880 f64.const -nan f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 11880 f64.load drop))
