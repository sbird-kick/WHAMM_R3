;; h5_indirect_33: Four-function chain via indirect
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 5 funcref)
  (elem (i32.const 0) $app_a $app_b $app_c $r3_d)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void))
  
  (func $r3_d (type $void_void))
  
  (func $app_c (export "app_c")
    i32.const 3 call_indirect (type $void_void))
  
  (func $app_b (export "app_b")
    i32.const 2 call_indirect (type $void_void))
  
  (func $app_a (export "app_a")
    i32.const 1 call_indirect (type $void_void)))
