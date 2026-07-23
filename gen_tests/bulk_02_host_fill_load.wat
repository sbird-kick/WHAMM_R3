;; bulk_02_host_fill_load: Host fills, real code loads (L events)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0x11 i32.const 100 i32.const 5 memory.fill
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load drop))
