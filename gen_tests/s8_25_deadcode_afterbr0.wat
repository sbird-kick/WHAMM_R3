;; s8_25_deadcode_afterbr0
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_load0)
  (func $r3_poke0
    i32.const 800 i32.const 33 i32.store)
  (func $app_load0 (export "app_load0")
    (local $v i32)
    block $b
      i32.const 800 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
