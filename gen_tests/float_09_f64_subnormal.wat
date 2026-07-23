;; f64 subnormal: r3 stores f64 4.9e-324 (smallest positive f64)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const 4.9e-324 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop)
)
