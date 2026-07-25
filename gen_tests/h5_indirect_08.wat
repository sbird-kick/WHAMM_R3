;; h5_indirect_08: Table index 2 (sparse table)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 5 funcref)
  (elem (i32.const 2) $r3_target)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_target (type $void_void))
  
  (func $app_caller (export "app_caller")
    i32.const 2 call_indirect (type $void_void)))
