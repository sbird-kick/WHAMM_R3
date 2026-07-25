;; h8_51_multimem_l: Two memories, load divergence on memory 1
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 123 i32.store $m0
    i32.const 0 i32.const 456 i32.store $m1
    call $app_readboth)
  (func $app_readboth (export "app_readboth")
    i32.const 0 i32.load $m0 drop
    i32.const 0 i32.load $m1 drop))
