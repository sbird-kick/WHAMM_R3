;; i32 global written by host, read by exported function → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 42
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
