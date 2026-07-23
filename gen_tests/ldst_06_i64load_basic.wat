;; intent: i64.load after r3 write
;; expected: EC(work), L at addr 0
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i64.const 0xDEADBEEFCAFEBABE i64.store
    call $work)
  (func $work (export "work")
    i32.const 0 i64.load drop))
