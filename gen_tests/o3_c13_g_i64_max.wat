;; o3_c13_g_i64_max
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 0x7fffffffffffffff global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
