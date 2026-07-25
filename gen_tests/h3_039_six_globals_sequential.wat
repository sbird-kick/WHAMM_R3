;; Six globals sequentially set and read
(module
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (global $g3 (export "g3") (mut i32) (i32.const 0))
  (global $g4 (export "g4") (mut i32) (i32.const 0))
  (global $g5 (export "g5") (mut i32) (i32.const 0))
  (global $g6 (export "g6") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 1
    global.set $g1
    i32.const 2
    global.set $g2
    i32.const 3
    global.set $g3
    i32.const 4
    global.set $g4
    i32.const 5
    global.set $g5
    i32.const 6
    global.set $g6
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g1 drop
    global.get $g2 drop
    global.get $g3 drop
    global.get $g4 drop
    global.get $g5 drop
    global.get $g6 drop))
