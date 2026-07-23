;; i64.max (9223372036854775807) written by host → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start")
    i64.const 9223372036854775807
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
