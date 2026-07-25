;; o3_c14_g_i64_allones
(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 0xffffffffffffffff global.set $g
    call $rd)
  (func $rd (export "rd")
    global.get $g drop))
