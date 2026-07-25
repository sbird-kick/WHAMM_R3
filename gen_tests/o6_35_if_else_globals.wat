;; if/else arms each read a distinct host global (G), result stored
(module
  (memory (export "memory") 1)
  (global $ga (export "ga") (mut i32) (i32.const 0))
  (global $gb (export "gb") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 501 global.set $ga
    i32.const 502 global.set $gb
    i32.const 1 call $app_ig drop
    i32.const 0 call $app_ig drop)
  (func $app_ig (export "app_ig") (param $c i32) (result i32)
    (if (result i32) (local.get $c)
      (then global.get $ga)
      (else global.get $gb))))
