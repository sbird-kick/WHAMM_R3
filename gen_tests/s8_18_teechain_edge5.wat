;; s8_18_teechain_edge5
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke5
    call $app_load5)
  (func $r3_poke5
    i32.const 481 i32.const 82 i32.store8)
  (func $app_load5 (export "app_load5")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 480
    local.tee $t1
    i32.const 1
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
