;; o3_e35_f64_flipsign
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 28848 f64.const 0x1.8p+10 f64.store
    i32.const 28848 f64.const -0x1.8p+10 f64.store
    call $rd)
  (func $rd (export "rd")
    i32.const 28848 f64.load drop))
