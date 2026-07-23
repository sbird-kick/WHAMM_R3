;; Mixed i64 and f64: r3 stores i64 then f64 at adjacent locations
;; Expected: L events at both addresses
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i64.const 0x123456789abcdef0 i64.store
    i32.const 8 f64.const 1.23e-45 f64.store
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load drop
    i32.const 8 f64.load drop)
)
