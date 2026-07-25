;; h8_15_l_ic_mg_g: L + IC + MG + G
(module
  (memory (export "memory") 1)
  (global $g9 (export "g9") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 55 global.set $g9
    i32.const 1024 i32.const 66 i32.store
    call $app_complex)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_complex (export "app_complex")
    i32.const 1024 i32.load drop
    call $r3_helper
    i32.const 1 memory.grow drop
    global.get $g9 drop))
