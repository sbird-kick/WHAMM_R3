;; memory.fill on m1 by host, then real loads → L event
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 100 i32.const 0xBB i32.const 10 memory.fill $m1
    call $work)
  (func $work (export "work")
    i32.const 100 i32.load $m1 drop))
