;; Host writes m1 at 300, real writes m0 at same addr, then both read → L for m1 only
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 300 i32.const 55 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 300 i32.const 99 i32.store $m0
    i32.const 300 i32.load $m0 drop
    i32.const 300 i32.load $m1 drop))
