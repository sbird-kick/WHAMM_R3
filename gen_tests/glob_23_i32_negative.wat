;; i32 negative value written by host → G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const -2147483648
    global.set $g
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
