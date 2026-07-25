;; h7_30_host_write_grow_4p: Host writes, app grows, reads same addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write_initial
    call $app_grow
    call $app_read)
  (func $r3_write_initial
    i32.const 63
    i32.const 217
    i32.store)
  (func $app_grow (export "app_grow")
    i32.const 4
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 63
    i32.load
    drop))
