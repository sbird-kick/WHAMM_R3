;; o3_d22_f32_neginf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 13336 f32.const -inf f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 13336 f32.load drop))
