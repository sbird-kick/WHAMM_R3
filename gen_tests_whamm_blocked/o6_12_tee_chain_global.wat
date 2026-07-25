;; local.tee chain feeding global.set; host wrote g_in, app reads (G)
(module
  (memory (export "memory") 1)
  (global $g_in (mut i32) (i32.const 0))
  (global $g_out (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 55 global.set $g_in
    call $app_tee)
  (func $app_tee (export "app_tee")
    (local $a i32) (local $b i32)
    global.get $g_in
    local.tee $a
    local.tee $b
    global.set $g_out))
