;; h8_47_ic_l_g: Internal call with load and global
(module
  (memory (export "memory") 1)
  (global $gp (export "gp") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 4096 i32.const 222 i32.store
    i32.const 777 global.set $gp
    call $app_complex)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_complex (export "app_complex")
    i32.const 4096 i32.load drop
    global.get $gp drop
    call $r3_helper))
