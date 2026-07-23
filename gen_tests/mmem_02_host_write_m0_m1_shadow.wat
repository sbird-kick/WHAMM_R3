;; Same address in m0 and m1, host writes m1, real reads both → L only for m1
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 10 i32.const 99 i32.store $m0
    i32.const 10 i32.const 77 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 10 i32.load $m0 drop
    i32.const 10 i32.load $m1 drop))
