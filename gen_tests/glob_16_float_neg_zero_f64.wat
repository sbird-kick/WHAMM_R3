;; f64 with -0.0 vs +0.0: different bit patterns → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start")
    f64.const -0.0
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
