;; f32 global, host mutates, app reads
(module
  (global $g (export "g") (mut f32) (f32.const 0.0))
  (func $r3_main (export "_start") (export "main")
    f32.const 330.1
    global.set $g
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g drop))
