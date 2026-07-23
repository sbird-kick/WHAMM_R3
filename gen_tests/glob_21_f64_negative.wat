;; f64 negative value written by host → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start")
    f64.const -1.5
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
