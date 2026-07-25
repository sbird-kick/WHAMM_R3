;; Alternating i32 and i64 globals
(module
  (global $gi1 (export "gi1") (mut i32) (i32.const 0))
  (global $gl1 (export "gl1") (mut i64) (i64.const 0))
  (global $gi2 (export "gi2") (mut i32) (i32.const 0))
  (global $gl2 (export "gl2") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 1
    global.set $gi1
    i64.const 2
    global.set $gl1
    i32.const 3
    global.set $gi2
    i64.const 4
    global.set $gl2
    call $app_read)
  (func $app_read (export "app_read")
    global.get $gi1 drop
    global.get $gl1 drop
    global.get $gi2 drop
    global.get $gl2 drop))
