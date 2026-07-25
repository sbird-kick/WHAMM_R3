;; h5_indirect_13: Indirect call with memory store in app
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $void_void))
  
  (func $app_caller (export "app_caller")
    i32.const 0 i32.const 99 i32.store
    i32.const 0 call_indirect (type $void_void)))
