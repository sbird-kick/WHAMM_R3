;; f64 written by r3, read as f32: r3 writes f64, real reads first half as f32
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const 2.71828 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
