;; s8_10_select_edge3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_load3)
  (func $r3_poke3
    i32.const 240 i32.const 53 i32.store8)
  (func $app_load3 (export "app_load3")
    (local $addr i32) (local $v i32)
    i32.const 236
    i32.const 239
    i32.const 1
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
