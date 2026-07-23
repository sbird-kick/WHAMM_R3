;; Active data segment into m1, real code loads it → no L (shadow seeded)
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data (memory 1) (i32.const 100) "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load $m1 drop))
