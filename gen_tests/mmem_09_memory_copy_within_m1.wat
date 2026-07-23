;; Host writes m0 and m1 at different offsets, real reads both → L for both
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 50 i32.const 11 i32.store $m0
    i32.const 75 i32.const 22 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 50 i32.load $m0 drop
    i32.const 75 i32.load $m1 drop))
