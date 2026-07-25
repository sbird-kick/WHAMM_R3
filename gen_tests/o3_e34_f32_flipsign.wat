;; o3_e34_f32_flipsign
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 10424 f32.const 0x1.5p+3 f32.store
    i32.const 10424 f32.const -0x1.5p+3 f32.store
    call $rd)
  (func $rd (export "rd")
    i32.const 10424 f32.load drop))
