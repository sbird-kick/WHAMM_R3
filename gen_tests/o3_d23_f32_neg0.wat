;; o3_d23_f32_neg0
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 31760 f32.const -0x0p+0 f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 31760 f32.load drop))
