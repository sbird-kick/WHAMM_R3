;; h8_23_multi_globals: Multiple global reads
(module
  (memory (export "memory") 1)
  (global $gf (export "gf") (mut i32) (i32.const 0))
  (global $gg (export "gg") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 55 global.set $gf
    i32.const 66 global.set $gg
    call $app_read_both)
  (func $app_read_both (export "app_read_both")
    global.get $gf drop
    global.get $gg drop))
