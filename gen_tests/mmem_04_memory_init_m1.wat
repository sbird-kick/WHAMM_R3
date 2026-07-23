;; memory.init from passive segment into m1, real code reads → no L
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data $p "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 4 memory.init (memory $m1) $p
    i32.const 100 i32.load $m1 drop))
