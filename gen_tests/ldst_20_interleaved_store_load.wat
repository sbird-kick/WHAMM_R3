;; intent: alternating r3 and real writes/loads
;; expected: EC(work), L (from first load)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xAAAAAAAA i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load drop
    i32.const 0 i32.const 0xBBBBBBBB i32.store
    i32.const 0 i32.load drop))
