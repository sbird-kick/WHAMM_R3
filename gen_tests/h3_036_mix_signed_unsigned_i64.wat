;; i64 alternating signed/unsigned values
(module
  (global $g1 (export "g1") (mut i64) (i64.const 0))
  (global $g2 (export "g2") (mut i64) (i64.const 0))
  (global $g3 (export "g3") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 1
    global.set $g1
    i64.const -1
    global.set $g2
    i64.const 9223372036854775806
    global.set $g3
    call $app_read)
  (func $app_read (export "app_read")
    global.get $g1 drop
    global.get $g2 drop
    global.get $g3 drop))
