;; h5_indirect_32: Nested r3 calls (r3 -> app indirect -> r3)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 3 funcref)
  (elem (i32.const 0) $app_mid)
  (elem (i32.const 1) $r3_leaf)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void))
  
  (func $r3_leaf (type $void_void))
  
  (func $app_mid (export "app_mid")
    i32.const 1 call_indirect (type $void_void)))
