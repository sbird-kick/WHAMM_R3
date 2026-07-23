;; Multiple f64 loads: r3 writes multiple f64s, real code loads all
;; Expected: L events at addrs 0, 8, 16
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f64.const 1.41421 f64.store
    i32.const 8 f64.const 2.71828 f64.store
    i32.const 16 f64.const 3.14159 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 f64.load drop
    i32.const 8 f64.load drop
    i32.const 16 f64.load drop)
)
