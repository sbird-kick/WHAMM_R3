;; o3_d25_f32_subnormal_max
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 12608 f32.const 0x1.fffffcp-127 f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 12608 f32.load drop))
