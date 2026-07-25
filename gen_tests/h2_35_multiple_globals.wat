;; Three float globals with different values
;; Expected: G events for all three
(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut f32) (f32.const 0.0))
  (global $g2 (export "g2") (mut f32) (f32.const 0.0))
  (global $g3 (export "g3") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const 1.5
    global.set $g1
    f32.const -2.75
    global.set $g2
    f32.const 4.125
    global.set $g3
    call $work)
  (func $work (export "work")
    global.get $g1
    drop
    global.get $g2
    drop
    global.get $g3
    drop))
