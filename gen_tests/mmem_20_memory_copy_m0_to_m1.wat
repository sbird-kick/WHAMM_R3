;; Real code writes m0, host writes m1, real reads both → L for m1 only
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 400 i32.const 88 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 400 i32.const 77 i32.store $m0
    i32.const 400 i32.load $m0 drop
    i32.const 400 i32.load $m1 drop))
