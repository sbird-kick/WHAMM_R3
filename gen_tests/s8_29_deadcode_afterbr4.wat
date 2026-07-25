;; s8_29_deadcode_afterbr4
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_load4)
  (func $r3_poke4
    i32.const 832 i32.const 37 i32.store)
  (func $app_load4 (export "app_load4")
    (local $v i32)
    block $b
      i32.const 832 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
