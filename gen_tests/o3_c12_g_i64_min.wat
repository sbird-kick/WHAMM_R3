;; o3_c12_g_i64_min
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 0x8000000000000000 global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
