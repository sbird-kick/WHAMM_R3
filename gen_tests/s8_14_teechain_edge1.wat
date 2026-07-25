;; s8_14_teechain_edge1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 417 i32.const 78 i32.store8)
  (func $app_load1 (export "app_load1")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 416
    local.tee $t1
    i32.const 0
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
