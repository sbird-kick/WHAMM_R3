;; h5_indirect_39: Table size 1 (minimal)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $app_only)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void))
  
  (func $app_only (export "app_only")))
