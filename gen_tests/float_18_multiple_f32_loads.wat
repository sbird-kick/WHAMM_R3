;; Multiple f32 loads: r3 writes multiple f32s, real code loads all
;; Expected: L events at addrs 0, 4, 8
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const 1.1 f32.store
    i32.const 4 f32.const 2.2 f32.store
    i32.const 8 f32.const 3.3 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop
    i32.const 4 f32.load drop
    i32.const 8 f32.load drop)
)
