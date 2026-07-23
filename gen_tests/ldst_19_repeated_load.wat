;; intent: load same address twice (only first produces L)
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x12345678 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load drop
    i32.const 0 i32.load drop))
