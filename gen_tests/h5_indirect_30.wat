;; h5_indirect_30: Mixed direct and indirect calls from same function
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $app_helper)
  
  (func $r3_main (export "_start") (export "main")
    call $app_mixed)
  
  (func $app_helper (export "app_helper"))
  
  (func $app_mixed (export "app_mixed")
    call $app_helper
    i32.const 0 call_indirect (type $void_void)
    call $app_helper))
