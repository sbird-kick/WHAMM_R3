;; Multiple EC calls with alternating global mutations
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g
    call $read1
    i32.const 3302
    global.set $g
    call $read2
    i32.const 3303
    global.set $g
    call $read3)
  (func $read1 (export "read1")
    global.get $g drop)
  (func $read2 (export "read2")
    global.get $g drop)
  (func $read3 (export "read3")
    global.get $g drop))
