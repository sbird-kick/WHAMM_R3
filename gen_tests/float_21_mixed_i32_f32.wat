;; Mixed int and float: r3 alternates i32 and f32 stores at consecutive addresses
;; Expected: L events at all addresses
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 42 i32.store
    i32.const 4 f32.const 1.5 f32.store
    i32.const 8 i32.const 99 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load drop
    i32.const 4 f32.load drop
    i32.const 8 i32.load drop)
)
