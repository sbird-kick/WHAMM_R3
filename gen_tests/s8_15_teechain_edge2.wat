;; s8_15_teechain_edge2
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke2
    call $app_load2)
  (func $r3_poke2
    i32.const 433 i32.const 79 i32.store8)
  (func $app_load2 (export "app_load2")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 432
    local.tee $t1
    i32.const 1
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
