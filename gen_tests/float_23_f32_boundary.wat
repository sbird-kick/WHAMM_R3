;; f32 at high memory: r3 stores f32 near end of page (addr 65532)
;; Expected: L event
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 65532 f32.const 999.999 f32.store
    call $work)
  (func $work (export "work")
    i32.const 65532 f32.load drop)
)
