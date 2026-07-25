;; h5_indirect_15: Indirect call at different table indices
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 6 funcref)
  (elem (i32.const 0) $app_a)
  (elem (i32.const 2) $app_b)
  (elem (i32.const 4) $app_c)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void)
    i32.const 2 call_indirect (type $void_void)
    i32.const 4 call_indirect (type $void_void))
  
  (func $app_a (export "app_a"))
  (func $app_b (export "app_b"))
  (func $app_c (export "app_c")))
