;; h8_55_multimem_ec_l_mg: EC + L + MG on two memories
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 200 i32.const 42 i32.store $m0
    i32.const 300 i32.const 84 i32.store $m1
    call $app_work)
  (func $app_work (export "app_work")
    i32.const 200 i32.load $m0 drop
    i32.const 1 memory.grow $m0 drop
    i32.const 300 i32.load $m1 drop
    i32.const 1 memory.grow $m1 drop))
