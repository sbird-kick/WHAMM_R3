;; EC parameter recording with f32
;; Expected events: EC with bitpattern for 3.14f32
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    f32.const 3.14
    call $take_f32)
  (func $take_f32 (export "take_f32") (param f32)
    ))
