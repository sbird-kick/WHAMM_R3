;; bulk_24_host_copy_bwd: Host does backward copy, real loads (L)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0x12 i32.const 100 i32.const 4 memory.fill
    i32.const 50 i32.const 100 i32.const 4 memory.copy
    call $work)
  (func $work (export "work")
    i32.const 50 i32.load drop))
