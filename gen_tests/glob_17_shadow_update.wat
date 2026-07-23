;; After first G, shadow updates: subsequent reads in same call don't repeat G
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 100
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop
    global.get $g
    drop
    global.get $g
    drop))
