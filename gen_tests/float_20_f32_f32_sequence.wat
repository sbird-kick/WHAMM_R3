;; Consecutive f32 stores: r3 writes two f32s at adjacent addresses
;; Expected: L events at addrs 0 and 4
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const 0.5 f32.store
    i32.const 4 f32.const -0.5 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load i32.const 4 f32.load drop drop)
)
