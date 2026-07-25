;; Global with f64 value: host sets to -4.5, app reads
;; Expected: G event
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f64.const -4.5
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
