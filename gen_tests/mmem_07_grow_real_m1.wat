;; Host writes at offset 200 to m1, real reads at 200 → L event
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start")
    i32.const 200 i32.const 123 i32.store $m1
    call $work)
  (func $work (export "work")
    i32.const 200 i32.load $m1 drop))
