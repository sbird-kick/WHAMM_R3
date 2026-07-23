;; intent: real store, r3 overwrite, real load (L event)
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work
    i32.const 0 i32.const 0xFFFFFFFF i32.store)
  (func $work (export "work")
    i32.const 0 i32.const 0x12345678 i32.store
    i32.const 0 i32.load drop))
