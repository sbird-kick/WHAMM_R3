;; Host writes to m1[0], real code reads m1 → L event for memidx 1
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 42 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load $m1 drop))
