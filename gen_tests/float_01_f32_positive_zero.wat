;; f32 constant: r3 stores f32 1.5, real code loads it
;; Expected: L event at addr 0 (host value differs from shadow zero)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 f32.const 1.5 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop)
)
