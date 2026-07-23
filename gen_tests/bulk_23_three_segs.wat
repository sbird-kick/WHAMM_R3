;; bulk_23_three_segs: Three segments with different content and sizes
(module
  (memory (export "mem") 1)
  (data $a "\01\02")
  (data $b "\11\22\33\44\55")
  (data $c "\aa\bb\cc\dd\ee\ee")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 50 i32.const 0 i32.const 2 memory.init $a
    i32.const 100 i32.const 0 i32.const 5 memory.init $b
    i32.const 200 i32.const 0 i32.const 6 memory.init $c
    i32.const 50 i32.load16_u drop
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop))
