;; h5_indirect_48: Indirect to app function then r3 function in sequence
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 4 funcref)
  (elem (i32.const 0) $app_work)
  (elem (i32.const 2) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void)
    call $app_call_r3)
  
  (func $r3_host (type $void_void))
  
  (func $app_call_r3 (export "app_call_r3")
    i32.const 2 call_indirect (type $void_void))
  
  (func $app_work (export "app_work")))
