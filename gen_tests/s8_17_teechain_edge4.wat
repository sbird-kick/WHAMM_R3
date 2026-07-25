;; s8_17_teechain_edge4
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_load4)
  (func $r3_poke4
    i32.const 465 i32.const 81 i32.store8)
  (func $app_load4 (export "app_load4")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 464
    local.tee $t1
    i32.const 0
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
