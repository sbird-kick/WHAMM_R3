;; o3_d18_f32_nan
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 51640 f32.const nan f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 51640 f32.load drop))
