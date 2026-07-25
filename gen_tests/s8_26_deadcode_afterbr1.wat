;; s8_26_deadcode_afterbr1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 808 i32.const 34 i32.store)
  (func $app_load1 (export "app_load1")
    (local $v i32)
    block $b
      i32.const 808 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
