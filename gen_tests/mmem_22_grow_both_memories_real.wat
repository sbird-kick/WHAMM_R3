;; Host writes m1 twice at different offsets, real reads both → two L events
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 100 i32.const 44 i32.store $m1
    i32.const 200 i32.const 55 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load $m1 drop
    i32.const 200 i32.load $m1 drop))
