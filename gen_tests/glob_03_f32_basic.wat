;; f32 global written by host, read by exported function → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start")
    f32.const 3.14
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
