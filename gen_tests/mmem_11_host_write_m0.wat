;; Host writes to m0, real reads m0 → L event
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 50 i32.const 0x99999999 i32.store $m0
    call $work)
  (func $work (export "work")
    i32.const 50 i32.load $m0 drop))
