;; memory.fill on m1 by real code, then load → no L
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0xAA i32.const 10 memory.fill $m1
    i32.const 100 i32.load $m1 drop))
