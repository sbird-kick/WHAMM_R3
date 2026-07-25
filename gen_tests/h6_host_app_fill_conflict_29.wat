;; h6_host_app_fill_conflict_29: host and app fill same region
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_fill
    call $app_fill
    call $app_read)
  (func $r3_fill
    i32.const 100 i32.const 0x11 i32.const 16 memory.fill)
  (func $app_fill (export "fill")
    i32.const 100 i32.const 0x22 i32.const 16 memory.fill)
  (func $app_read (export "read")
    i32.const 100 i32.load drop))
