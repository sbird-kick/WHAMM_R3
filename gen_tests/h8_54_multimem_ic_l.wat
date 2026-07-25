;; h8_54_multimem_ic_l: Multi-memory with IC and load
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 50 i32.const 77 i32.store $m0
    i32.const 60 i32.const 88 i32.store $m1
    call $app_work)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_work (export "app_work")
    i32.const 50 i32.load $m0 drop
    i32.const 60 i32.load $m1 drop
    call $r3_helper))
