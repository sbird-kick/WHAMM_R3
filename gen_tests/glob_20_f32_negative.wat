;; f32 negative value written by host → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start")
    f32.const -2.5
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
