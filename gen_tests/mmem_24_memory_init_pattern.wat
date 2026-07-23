;; memory.init with specific load pattern across memories
;; Real inits m1 with data, then loads m0 and m1
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data (memory 0) (i32.const 0) "\01\02\03\04")
  (data $p "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 120 i32.const 0 i32.const 4 memory.init (memory $m1) $p
    i32.const 0 i32.load $m0 drop
    i32.const 120 i32.load $m1 drop))
