;; Real reads uninitialized m1 address, then host writes
;; First load gets 0, no event, second gets host value after boundary
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 50 i32.const 0xDEADBEEF i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 200 i32.load $m1 drop
    i32.const 50 i32.load $m1 drop))
