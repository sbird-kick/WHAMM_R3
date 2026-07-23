;; Real loads same address multiple times after host write
;; First load → L, subsequent loads → no L (shadow already updated)
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xCAFECAFE i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load $m1 drop
    i32.const 0 i32.load $m1 drop
    i32.const 0 i32.load $m1 drop))
