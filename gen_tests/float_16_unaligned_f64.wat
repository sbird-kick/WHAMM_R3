;; Unaligned f64: r3 stores f64 at odd address (addr 5)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 5 f64.const 1.61803 f64.store
    call $work)
  (func $work (export "work")
    i32.const 5 f64.load drop)
)
