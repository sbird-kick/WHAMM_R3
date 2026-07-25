;; h5_indirect_23: Multiple independent calls to same function index
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 3 funcref)
  (elem (i32.const 0) $app_fn)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_void)
    i32.const 0 call_indirect (type $void_void)
    i32.const 0 call_indirect (type $void_void))
  
  (func $app_fn (export "app_fn")))
