;; h6_ec_copy_24: EC with copy
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_setup
    call $app_copy)
  (func $app_setup (export "setup")
    i32.const 50 i32.const 0x99 i32.store)
  (func $app_copy (export "copy")
    i32.const 100 i32.const 50 i32.const 8 memory.copy))
