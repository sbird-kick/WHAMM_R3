;; bulk_07_two_inits_same: Two inits from same segment to different dests
(module
  (memory (export "mem") 1)
  (data $seg "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 4 memory.init $seg
    i32.const 200 i32.const 0 i32.const 4 memory.init $seg
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop))
