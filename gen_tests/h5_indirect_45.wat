;; h5_indirect_45: Indirect call with large table size
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 50 funcref)
  (elem (i32.const 25) $app_mid)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 25 call_indirect (type $void_void))
  
  (func $app_mid (export "app_mid")))
