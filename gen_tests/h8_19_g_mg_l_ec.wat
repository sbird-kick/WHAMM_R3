;; h8_19_g_mg_l_ec: G + MG + L + EC
(module
  (memory (export "memory") 1)
  (global $gc (export "gc") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 135 global.set $gc
    i32.const 16384 i32.const 99 i32.store
    call $app_multi)
  (func $app_multi (export "app_multi")
    global.get $gc drop
    i32.const 1 memory.grow drop
    i32.const 16384 i32.load drop))
