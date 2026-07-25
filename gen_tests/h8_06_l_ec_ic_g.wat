;; h8_06_l_ec_ic_g: Four events - L + EC + IC + G
;; r3_main sets memory and global, calls app (EC), app reads memory (L), calls helper (IC), reads global (G)
(module
  (memory (export "memory") 1)
  (global $g3 (export "g3") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 48 i32.const 88 i32.store
    i32.const 7 global.set $g3
    call $app_process)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_process (export "app_process")
    i32.const 48 i32.load drop
    call $r3_helper
    global.get $g3 drop))
