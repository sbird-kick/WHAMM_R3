;; o3_c16_g_f64_neg0
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f64) (f64.const 0))
  (func $r3_main (export "_start") (export "main")
    f64.const -0x0p+0 global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
