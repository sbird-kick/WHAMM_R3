;; bulk_20_host_fill_multi: Host fills overlapping regions, real loads (L)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0x11 i32.const 100 i32.const 10 memory.fill
    i32.const 0x22 i32.const 150 i32.const 10 memory.fill
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load drop
    i32.const 150 i32.load drop))
