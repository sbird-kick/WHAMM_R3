;; s8_12_select_edge5
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke5
    call $app_load5)
  (func $r3_poke5
    i32.const 264 i32.const 55 i32.store8)
  (func $app_load5 (export "app_load5")
    (local $addr i32) (local $v i32)
    i32.const 260
    i32.const 263
    i32.const 1
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
