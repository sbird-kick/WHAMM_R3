;; h6_host_fill_read_18: host fills, app reads (L event)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_fill
    call $app_read)
  (func $r3_fill
    i32.const 200
    i32.const 0x42
    i32.const 32
    memory.fill)
  (func $app_read (export "read")
    i32.const 200 i32.load drop))
