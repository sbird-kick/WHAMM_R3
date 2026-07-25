;; Two i32 globals, both mutated and read
(module
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g1
    i32.const 3302
    global.set $g2
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g1 drop
    global.get $g2 drop))
