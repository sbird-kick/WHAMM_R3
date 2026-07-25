;; i32 boundary values: 0, 1, -1, max, min-1
(module
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (global $g3 (export "g3") (mut i32) (i32.const 0))
  (global $g4 (export "g4") (mut i32) (i32.const 0))
  (global $g5 (export "g5") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 0
    global.set $g1
    i32.const 1
    global.set $g2
    i32.const -1
    global.set $g3
    i32.const 2147483647
    global.set $g4
    i32.const -2147483647
    global.set $g5
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g1 drop
    global.get $g2 drop
    global.get $g3 drop
    global.get $g4 drop
    global.get $g5 drop))
