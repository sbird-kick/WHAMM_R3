;; h8_16_g_l_mg_ec: G + L + MG + EC
(module
  (memory (export "memory") 1)
  (global $ga (export "ga") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 88 global.set $ga
    i32.const 2048 i32.const 44 i32.store
    call $app_all)
  (func $app_all (export "app_all")
    global.get $ga drop
    i32.const 2048 i32.load drop
    i32.const 2 memory.grow drop))
