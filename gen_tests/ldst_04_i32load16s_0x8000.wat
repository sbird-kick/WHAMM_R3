;; intent: i32.load16_s with 0x8000 sign bit set
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x8000 i32.store16
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load16_s drop))
