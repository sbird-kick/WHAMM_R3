;; h8_26_ec_l_g_mg_ic: Five events in one test
(module
  (memory (export "memory") 1)
  (global $gh (export "gh") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 88 global.set $gh
    i32.const 512 i32.const 77 i32.store
    call $app_supercomplex)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_supercomplex (export "app_supercomplex")
    i32.const 512 i32.load drop
    i32.const 1 memory.grow drop
    global.get $gh drop
    call $r3_helper))
