;; s8_28_deadcode_afterbr3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_load3)
  (func $r3_poke3
    i32.const 824 i32.const 36 i32.store)
  (func $app_load3 (export "app_load3")
    (local $v i32)
    block $b
      i32.const 824 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
