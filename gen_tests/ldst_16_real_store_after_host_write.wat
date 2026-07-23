;; intent: r3 write, real store (updates shadow), load (no L)
;; expected: EC(work)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xDEADBEEF i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.const 0x12345678 i32.store
    i32.const 0 i32.load drop))
