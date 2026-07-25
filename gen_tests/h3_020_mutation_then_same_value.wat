;; Set global to a value, then to same value: second mutation still diverges
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g
    i32.const 3301
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
