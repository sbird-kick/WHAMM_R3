;; App reads global without any host mutation: no G event
(module
  (global $g (export "g") (mut i32) (i32.const 3301))
  (func $r3_main (export "_start") (export "main")
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
