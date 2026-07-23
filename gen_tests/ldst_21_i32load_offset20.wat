;; intent: i32.load offset=20 after r3 write
;; expected: EC(work), L at addr 20
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 20 i32.const 0xFEDCBA98 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load offset=20 drop))
