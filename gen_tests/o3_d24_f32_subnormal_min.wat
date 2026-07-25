;; o3_d24_f32_subnormal_min
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 50184 f32.const 0x1p-149 f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 50184 f32.load drop))
