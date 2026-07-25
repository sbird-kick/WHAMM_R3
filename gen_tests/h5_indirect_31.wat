;; h5_indirect_31: Table at different elem offset (index 3)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 8 funcref)
  (elem (i32.const 3) $app_fn)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 3 call_indirect (type $void_void))
  
  (func $app_fn (export "app_fn")))
