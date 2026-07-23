;; Active data segment into m0, real code loads → no L
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data (memory 0) (i32.const 50) "\11\22\33\44")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 50 i32.load $m0 drop))
