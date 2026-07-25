;; h8_02_g_l_ec: G (global divergence) + L (load divergence) + EC (external call)
;; r3_main modifies global and memory, then calls app_check (EC)
;; app_check reads the global (G) and memory (L)
(module
  (memory (export "memory") 1)
  (global $g0 (export "g0") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 71 global.set $g0
    i32.const 16 i32.const 222 i32.store
    call $app_check)
  (func $app_check (export "app_check")
    global.get $g0 drop
    i32.const 16 i32.load drop))
