;; h5_indirect_37: Three separate indirect calls to different functions
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 5 funcref)
  (elem (i32.const 0) $app_a)
  (elem (i32.const 2) $app_b)
  (elem (i32.const 4) $r3_c)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void)
    i32.const 2 call_indirect (type $void_void)
    call $app_chain)
  
  (func $r3_c (type $void_void))
  
  (func $app_chain (export "app_chain")
    i32.const 4 call_indirect (type $void_void))
  
  (func $app_a (export "app_a"))
  (func $app_b (export "app_b")))
