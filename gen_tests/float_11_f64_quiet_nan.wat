;; f64 quiet NaN: r3 stores f64 NaN via bit pattern, real code loads it
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const nan:0x8000000000000 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop)
)
