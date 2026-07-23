;; Alternating writers: host→real→host across calls
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 10
    global.set $g
    call $work1
    i32.const 20
    global.set $g
    call $work2)
  (func $work1 (export "work1")
    global.get $g
    drop
    i32.const 15
    global.set $g)
  (func $work2 (export "work2")
    global.get $g
    drop))
