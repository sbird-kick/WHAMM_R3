;; f64 negative zero: r3 stores -0.0 (bit pattern 0x8000000000000000)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const -0.0 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop)
)
