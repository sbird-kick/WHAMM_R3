;; Many globals (8+): only some diverge
(module
  (memory (export "mem") 1)
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (global $g3 (export "g3") (mut i32) (i32.const 0))
  (global $g4 (export "g4") (mut i32) (i32.const 0))
  (global $g5 (export "g5") (mut i32) (i32.const 0))
  (global $g6 (export "g6") (mut i32) (i32.const 0))
  (global $g7 (export "g7") (mut i32) (i32.const 0))
  (global $g8 (export "g8") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 11
    global.set $g1
    i32.const 33
    global.set $g3
    i32.const 77
    global.set $g7
    call $work)
  (func $work (export "work")
    global.get $g1
    drop
    global.get $g2
    drop
    global.get $g3
    drop
    global.get $g8
    drop))
