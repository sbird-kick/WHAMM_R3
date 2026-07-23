;; Chain: real→r3→real→r3
;; Expected events: EC for $work, IC/IR for $r3_h1, IC/IR for $r3_h2
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_h1)
  (func $r3_h1
    call $mid)
  (func $mid
    call $r3_h2)
  (func $r3_h2
    nop))
