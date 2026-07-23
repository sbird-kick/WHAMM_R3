;; intent: 0xFFFFFFFF with i64.load32_s sign extension
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xFFFFFFFF i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load32_s drop))
