;; F32 global with negative infinity simulation via bit pattern
;; Expected: G event
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const -100.5
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
