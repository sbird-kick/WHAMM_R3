;; Real code writes global then reads: no G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 55
    global.set $g
    global.get $g
    drop))
