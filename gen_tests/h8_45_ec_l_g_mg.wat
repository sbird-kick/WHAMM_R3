;; h8_45_ec_l_g_mg: Four main events
(module
  (memory (export "memory") 1)
  (global $go (export "go") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 2048 i32.const 123 i32.store
    i32.const 555 global.set $go
    call $app_allevents)
  (func $app_allevents (export "app_allevents")
    i32.const 2048 i32.load drop
    global.get $go drop
    i32.const 1 memory.grow drop))
