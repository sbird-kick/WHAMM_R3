;; memory.init from passive segment into m0 → no L
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data $p "\11\22\33\44")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 80 i32.const 0 i32.const 4 memory.init (memory $m0) $p
    i32.const 80 i32.load $m0 drop))
