;; f32 negative zero: r3 stores -0.0 (bit pattern differs from +0.0)
;; Expected: L event (shadow +0.0 differs from host -0.0)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const -0.0 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
