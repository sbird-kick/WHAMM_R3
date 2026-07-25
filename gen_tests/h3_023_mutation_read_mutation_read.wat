;; Alternating mutations and reads across function boundaries
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g
    call $app_read1
    i32.const 3302
    global.set $g
    call $app_read2)
  (func $app_read1 (export "app_read1")
    global.get $g drop)
  (func $app_read2 (export "app_read2")
    global.get $g drop))
