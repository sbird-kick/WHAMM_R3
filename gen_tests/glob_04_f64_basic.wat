;; f64 global written by host, read by exported function → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut f64) (f64.const 0.0))
  (func $r3_main (export "_start")
    f64.const 2.71828
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
