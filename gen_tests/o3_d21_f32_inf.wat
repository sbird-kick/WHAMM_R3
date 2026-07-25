;; o3_d21_f32_inf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 50912 f32.const inf f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 50912 f32.load drop))
