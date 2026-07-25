;; h5_indirect_18: Indirect call with mutable global access
(module
  (memory (export "memory") 1)
  (global $counter (mut i32) (i32.const 0))
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_inc_global)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_inc_global (type $void_void)
    global.get $counter
    i32.const 1 i32.add
    global.set $counter)
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_void)))
