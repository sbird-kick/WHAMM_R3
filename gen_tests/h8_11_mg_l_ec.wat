;; h8_11_mg_l_ec: MG + L + EC in sequence
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_manage)
  (func $r3_readback
    i32.const 128 i32.load drop)
  (func $app_manage (export "app_manage")
    i32.const 1 memory.grow drop
    i32.const 128 i32.const 111 i32.store
    call $r3_readback))
