;; s8_16_teechain_edge3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_load3)
  (func $r3_poke3
    i32.const 449 i32.const 80 i32.store8)
  (func $app_load3 (export "app_load3")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 448
    local.tee $t1
    i32.const -1
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
