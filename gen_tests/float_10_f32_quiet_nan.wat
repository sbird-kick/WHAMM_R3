;; f32 quiet NaN: r3 stores f32 NaN via bit pattern, real code loads it
;; Expected: L event (no arithmetic on NaN, just constant storage)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const nan:0x200000 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
