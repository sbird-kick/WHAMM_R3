;; s8_13_teechain_edge0
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_load0)
  (func $r3_poke0
    i32.const 401 i32.const 77 i32.store8)
  (func $app_load0 (export "app_load0")
    (local $t1 i32) (local $t2 i32) (local $t3 i32)
    i32.const 400
    local.tee $t1
    i32.const -1
    i32.add
    local.tee $t2
    local.tee $t3
    i32.load
    drop)
)
