;; h8_14_mg_ec_g: MG + EC + G
(module
  (memory (export "memory") 1)
  (global $g8 (export "g8") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 44 global.set $g8
    call $app_grow_check)
  (func $app_grow_check (export "app_grow_check")
    i32.const 2 memory.grow drop
    global.get $g8 drop))
