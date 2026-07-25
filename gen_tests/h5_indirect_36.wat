;; h5_indirect_36: Table with elem at offset 4 with 2 functions
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 10 funcref)
  (elem (i32.const 4) $app_x $app_y)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 4 call_indirect (type $void_void)
    i32.const 5 call_indirect (type $void_void))
  
  (func $app_x (export "app_x"))
  (func $app_y (export "app_y")))
