;; Mix of f32 and f64 globals
;; Expected: G events
(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut f32) (f32.const 0.0))
  (global $g2 (export "g2") (mut f64) (f64.const 0.0))
  (global $g3 (export "g3") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const 2.5
    global.set $g1
    f64.const -1.75
    global.set $g2
    f32.const 0.625
    global.set $g3
    call $work)
  (func $work (export "work")
    global.get $g1
    drop
    global.get $g2
    drop
    global.get $g3
    drop))
