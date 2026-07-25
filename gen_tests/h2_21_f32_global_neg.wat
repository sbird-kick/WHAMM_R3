;; F32 global with negative value: -7.5
;; Expected: G event
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const -7.5
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
