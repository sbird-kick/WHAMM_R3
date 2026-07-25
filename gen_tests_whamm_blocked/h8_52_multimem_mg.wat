;; h8_52_multimem_mg: Two memories, grow both
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_expand)
  (func $app_expand (export "app_expand")
    i32.const 2 memory.grow $m0 drop
    i32.const 2 memory.grow $m1 drop))
