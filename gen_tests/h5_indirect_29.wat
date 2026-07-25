;; h5_indirect_29: Indirect call in loop (controlled iteration)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $app_fn)
  
  (func $r3_main (export "_start") (export "main")
    call $app_do_loop)
  
  (func $app_fn (export "app_fn"))
  
  (func $app_do_loop (export "app_do_loop")
    (local $i i32)
    i32.const 0
    local.set $i
    block $break
      loop $continue
        local.get $i i32.const 3 i32.ge_u
        br_if $break
        i32.const 0 call_indirect (type $void_void)
        local.get $i i32.const 1 i32.add
        local.set $i
        br $continue
      end
    end))
