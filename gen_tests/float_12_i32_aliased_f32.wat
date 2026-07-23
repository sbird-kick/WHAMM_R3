;; Type aliasing: r3 writes i32 0x3f800000, real reads as f32 (should be 1.0)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x3f800000 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
