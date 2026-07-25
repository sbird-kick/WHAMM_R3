;; s8_07_select_edge0
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_load0)
  (func $r3_poke0
    i32.const 204 i32.const 50 i32.store8)
  (func $app_load0 (export "app_load0")
    (local $addr i32) (local $v i32)
    i32.const 200
    i32.const 203
    i32.const 0
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
