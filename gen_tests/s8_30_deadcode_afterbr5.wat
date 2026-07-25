;; s8_30_deadcode_afterbr5
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke5
    call $app_load5)
  (func $r3_poke5
    i32.const 840 i32.const 38 i32.store)
  (func $app_load5 (export "app_load5")
    (local $v i32)
    block $b
      i32.const 840 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
