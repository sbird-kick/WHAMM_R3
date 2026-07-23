;; Multiple host writes to same address, real code reads once
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x11111111 i32.store $m1
    i32.const 0 i32.const 0x22222222 i32.store $m1
    i32.const 0 i32.const 0x33333333 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load $m1 drop))
