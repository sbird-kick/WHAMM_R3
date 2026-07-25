;; h5_indirect_02: Simple indirect call to real function
;; EC event: r3_main calls app via indirect
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $app_work)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void))
  
  (func $app_work (export "app_work")
    nop))
