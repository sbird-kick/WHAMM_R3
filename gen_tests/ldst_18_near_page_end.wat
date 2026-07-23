;; intent: load near page end (65530-65535)
;; expected: EC(work), L at addr 65530
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 65530 i32.const 0xFEDCBA98 i32.store
    call $work)
  (func $work (export "work")
    i32.const 65530 i32.load drop))
