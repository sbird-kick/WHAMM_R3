;; o3_c17_g_f32_inf
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut f32) (f32.const 0))
  (func $r3_main (export "_start") (export "main")
    f32.const inf global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
