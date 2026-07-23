;; Nested real calls at depth > 0: no additional EC events
;; Expected events: EC for $a only
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $a)
  (func $a (export "a")
    call $b
    call $c)
  (func $b (export "b")
    nop)
  (func $c (export "c")
    nop))
