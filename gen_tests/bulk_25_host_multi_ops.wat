;; bulk_25_host_multi_ops: Host does multiple bulk ops, real loads (L)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0xAA i32.const 100 i32.const 4 memory.fill
    i32.const 200 i32.const 100 i32.const 4 memory.copy
    i32.const 0xBB i32.const 300 i32.const 4 memory.fill
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop
    i32.const 300 i32.load drop))
