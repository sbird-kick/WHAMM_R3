;; h6_host_copy_read_19: host copies, app reads (L event)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_setup
    call $r3_copy
    call $app_read)
  (func $r3_setup
    i32.const 50 i32.const 0x77 i32.store)
  (func $r3_copy
    i32.const 100
    i32.const 50
    i32.const 16
    memory.copy)
  (func $app_read (export "read")
    i32.const 100 i32.load drop))
