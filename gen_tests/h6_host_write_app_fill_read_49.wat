;; h6_host_write_app_fill_read_49: host write, app fill, app read
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_write
    call $app_fill
    call $app_read)
  (func $r3_write
    i32.const 100 i32.const 0x55 i32.store)
  (func $app_fill (export "fill")
    i32.const 100 i32.const 0x88 i32.const 16 memory.fill)
  (func $app_read (export "read")
    i32.const 100 i32.load drop))
