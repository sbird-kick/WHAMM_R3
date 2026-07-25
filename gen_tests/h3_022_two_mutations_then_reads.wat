;; Two sequential mutations then two separate reads
(module
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g1
    i32.const 3302
    global.set $g2
    call $app_read1
    call $app_read2)
  (func $app_read1 (export "app_read1")
    global.get $g1 drop)
  (func $app_read2 (export "app_read2")
    global.get $g2 drop))
