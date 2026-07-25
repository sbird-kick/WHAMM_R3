;; h8_01_ec_l_ic: EC (external call) + L (load divergence) + IC (import call)
;; r3_main calls app_read (EC), app_read calls r3_helper (IC), app_read loads memory modified by r3_main (L)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 8 i32.const 123 i32.store
    call $app_read)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_read (export "app_read")
    i32.const 8 i32.load drop
    call $r3_helper))
