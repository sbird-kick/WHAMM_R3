;; bulk_16_host_init_load: Host executes init, real code loads (L)
(module
  (memory (export "mem") 1)
  (data $seg "\11\22\33\44")
  (func $r3_main (export "_start")
    i32.const 100 i32.const 0 i32.const 4 memory.init $seg
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load drop))
