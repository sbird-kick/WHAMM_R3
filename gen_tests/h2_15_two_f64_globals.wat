;; Two f64 globals with different values
;; Expected: G events
(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut f64) (f64.const 0.0))
  (global $g2 (export "g2") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const 2.75
    global.set $g1
    f64.const -0.5
    global.set $g2
    call $work)
  (func $work (export "work")
    global.get $g1
    drop
    global.get $g2
    drop))
