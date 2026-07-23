;; f32 signaling NaN: r3 stores signaling NaN via bit pattern
;; Expected: L event (stored as constant, no arithmetic)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const nan:0x100000 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
