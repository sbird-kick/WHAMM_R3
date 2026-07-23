;; intent: i64.load8_s with 0x80
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x80 i32.store8
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load8_s drop))
