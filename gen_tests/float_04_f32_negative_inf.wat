;; f32 negative infinity: r3 stores -inf, real code loads it
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const -inf f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
