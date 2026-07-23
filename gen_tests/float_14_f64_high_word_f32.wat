;; f64 to f32 aliasing: real writes f64, then reads first 4 bytes as f32
;; Expected: no L event (real wrote it, shadow matches)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0 f64.const 3.14159 f64.store
    i32.const 0 f32.load drop)
)
