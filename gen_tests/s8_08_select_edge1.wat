;; s8_08_select_edge1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 216 i32.const 51 i32.store8)
  (func $app_load1 (export "app_load1")
    (local $addr i32) (local $v i32)
    i32.const 212
    i32.const 215
    i32.const 1
    select
    local.set $addr
    local.get $addr i32.load local.set $v
    local.get $v drop)
)
