;; Repeated reads after single mutation: only one G event
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3302
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop
    global.get $g drop
    global.get $g drop))
