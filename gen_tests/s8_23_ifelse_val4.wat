;; s8_23_ifelse_val4
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_load4)
  (func $r3_poke4
    i32.const 683 i32.const 13 i32.store8)
  (func $app_load4 (export "app_load4")
    (local $addr i32) (local $sum i32) (local $c i32)
    i32.const 1
    if (result i32)
      i32.const 680
    else
      i32.const 682
    end
    local.set $addr
    i32.const 0 local.set $c
    loop $lp
      local.get $addr local.get $c i32.add i32.load8_u
      local.get $sum i32.add local.set $sum
      local.get $c i32.const 1 i32.add local.tee $c
      i32.const 4 i32.lt_s
      br_if $lp
    end
    local.get $sum drop)
)
