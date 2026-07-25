;; h5_indirect_50: Five function chain with alternating app/r3 calls
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 5 funcref)
  
  (func $r3_main (export "_start") (export "main")
    call $app_start)
  
  (func $r3_h1 (type $void_void))
  
  (func $app_start (export "app_start")
    i32.const 1 call_indirect (type $void_void))
  
  (func $app_m2 (export "app_m2")
    i32.const 2 call_indirect (type $void_void))
  
  (func $app_end (export "app_end")
    i32.const 0 call_indirect (type $void_void))
  
  (elem (i32.const 0) $r3_h1)
  (elem (i32.const 1) $app_m2)
  (elem (i32.const 2) $app_end))
