;; Multiple EC events: global diverges, first read gets G, but second call after host update gets new G
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 11
    global.set $g
    call $work1
    i32.const 22
    global.set $g
    call $work2)
  (func $work1 (export "work1")
    global.get $g
    drop)
  (func $work2 (export "work2")
    global.get $g
    drop))
