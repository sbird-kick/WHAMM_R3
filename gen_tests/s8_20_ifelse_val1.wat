;; s8_20_ifelse_val1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 623 i32.const 10 i32.store8)
  (func $app_load1 (export "app_load1")
    (local $addr i32) (local $sum i32) (local $c i32)
    i32.const 0
    if (result i32)
      i32.const 620
    else
      i32.const 622
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
