;; Deep chain: multiple alternations between real and r3
;; Expected events: EC for $work, IC/IR for $r3_h1, $r3_h2, $r3_h3
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_h1)
  (func $r3_h1
    call $mid1)
  (func $mid1
    call $r3_h2)
  (func $r3_h2
    call $mid2)
  (func $mid2
    call $r3_h3)
  (func $r3_h3
    nop))
