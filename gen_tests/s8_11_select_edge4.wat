;; s8_11_select_edge4
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_load4)
  (func $r3_poke4
    i32.const 252 i32.const 54 i32.store8)
  (func $app_load4 (export "app_load4")
    (local $addr i32) (local $v i32)
    i32.const 248
    i32.const 251
    i32.const 0
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
