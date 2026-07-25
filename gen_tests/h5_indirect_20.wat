;; h5_indirect_20: Large table with sparse population
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 20 funcref)
  (elem (i32.const 5) $app_fn)
  (elem (i32.const 15) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $void_void))
  
  (func $app_fn (export "app_fn")
    i32.const 15 call_indirect (type $void_void))
  
  (func $app_caller (export "app_caller")
    i32.const 5 call_indirect (type $void_void)))
