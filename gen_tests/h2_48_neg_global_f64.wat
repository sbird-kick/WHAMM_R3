;; F64 global with large negative value
;; Expected: G event
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const -256.375
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
