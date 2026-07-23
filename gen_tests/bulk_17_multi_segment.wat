;; bulk_17_multi_segment: Multiple segments inited to different offsets
(module
  (memory (export "mem") 1)
  (data $s1 "\aa\bb\cc")
  (data $s2 "\11\22\33")
  (data $s3 "\ff\ee\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 3 memory.init $s1
    i32.const 200 i32.const 0 i32.const 3 memory.init $s2
    i32.const 300 i32.const 0 i32.const 3 memory.init $s3
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop
    i32.const 300 i32.load drop))
