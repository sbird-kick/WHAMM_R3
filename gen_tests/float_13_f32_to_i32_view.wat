;; Type aliasing reverse: real writes f32 2.5, reads same 4 bytes as i32
;; Expected: no L event (real code wrote it, shadow matches)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0 f32.const 2.5 f32.store
    i32.const 0 i32.load drop)
)
