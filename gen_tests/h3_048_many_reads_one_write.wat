;; Single write followed by many reads (shadow updates after first)
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g
    call $app_multi_read)
  (func $app_multi_read (export "app_multi_read")
    global.get $g drop
    global.get $g drop
    global.get $g drop
    global.get $g drop
    global.get $g drop))
