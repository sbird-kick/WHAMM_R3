;; Callback: r3 calls real which calls r3 back (IC before EC)
;; Expected events: EC for $work, IC/IR for $r3_callback, IC/IR for $r3_work
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_callback)
  (func $r3_callback
    call $r3_work)
  (func $r3_work
    nop))
