;; f64 very small value: r3 stores 2.2250738585072014e-308 (near min normal)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const 2.2250738585072014e-308 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop)
)
