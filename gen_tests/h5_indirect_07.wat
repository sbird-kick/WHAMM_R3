;; h5_indirect_07: Mixed real and r3 functions in table
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 3 funcref)
  (elem (i32.const 0) $app_work $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $void_void))
  
  (func $app_work (export "app_work")
    i32.const 1 call_indirect (type $void_void))
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_void)))
