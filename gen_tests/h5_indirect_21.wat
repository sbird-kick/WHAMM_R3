;; h5_indirect_21: Chained indirect calls (A->B->C)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 4 funcref)
  (elem (i32.const 0) $app_a $app_b $r3_c)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void))
  
  (func $r3_c (type $void_void))
  
  (func $app_b (export "app_b")
    i32.const 2 call_indirect (type $void_void))
  
  (func $app_a (export "app_a")
    i32.const 1 call_indirect (type $void_void)))
