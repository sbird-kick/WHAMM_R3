;; s8_09_select_edge2
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke2
    call $app_load2)
  (func $r3_poke2
    i32.const 228 i32.const 52 i32.store8)
  (func $app_load2 (export "app_load2")
    (local $addr i32) (local $v i32)
    i32.const 224
    i32.const 227
    i32.const 0
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
