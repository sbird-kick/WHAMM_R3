;; h8_17_ec_l_mg: Simple EC + L + MG
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 4096 i32.const 123 i32.store
    call $app_work)
  (func $app_work (export "app_work")
    i32.const 4096 i32.load drop
    i32.const 3 memory.grow drop))
