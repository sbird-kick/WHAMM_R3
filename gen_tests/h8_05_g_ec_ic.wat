;; h8_05_g_ec_ic: G + EC + IC
;; r3_main sets global, calls app_func (EC), app_func reads global and calls r3_helper (IC)
(module
  (memory (export "memory") 1)
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 39 global.set $g2
    call $app_func)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_func (export "app_func")
    global.get $g2 drop
    call $r3_helper))
