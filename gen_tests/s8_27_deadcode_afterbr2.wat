;; s8_27_deadcode_afterbr2
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke2
    call $app_load2)
  (func $r3_poke2
    i32.const 816 i32.const 35 i32.store)
  (func $app_load2 (export "app_load2")
    (local $v i32)
    block $b
      i32.const 816 i32.load local.set $v
      br $b
      ;; dead code below: never executed, statically unreachable stack-wise
      unreachable
    end
    local.get $v drop)
)
