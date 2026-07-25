;; o3_c15_g_f64_nan
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f64) (f64.const 0))
  (func $r3_main (export "_start") (export "main")
    f64.const nan global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
