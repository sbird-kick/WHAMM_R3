;; f32 subnormal: r3 stores very small subnormal f32
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const 1.4e-45 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
