;; F64 global with negative value: -8.125
;; Expected: G event
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const -8.125
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
