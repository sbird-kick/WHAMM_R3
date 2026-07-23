;; intent: i64.load8_u with 0xFF
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xFF i32.store8
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load8_u drop))
