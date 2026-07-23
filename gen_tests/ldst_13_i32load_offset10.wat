;; intent: i32.load offset=10 after r3 write at addr 10
;; expected: EC(work), L at addr 10
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 10 i32.const 0x11223344 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load offset=10 drop))
