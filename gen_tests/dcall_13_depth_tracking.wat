;; Depth tracking: r3_main→$a→$b→$c shows increasing depth
;; Expected events: EC for $a only (depth > 0 calls don't generate EC)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $a)
  (func $a (export "a")
    call $b)
  (func $b (export "b")
    call $c)
  (func $c (export "c")
    nop))
