;; Real fills m1, host writes m0, real reads both → L for m0 only
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 500 i32.const 33 i32.store $m0
    call $work)
  (func $work (export "work")
    i32.const 120 i32.const 0xFF i32.const 8 memory.fill $m1
    i32.const 500 i32.load $m0 drop
    i32.const 120 i32.load $m1 drop))
