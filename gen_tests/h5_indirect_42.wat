;; h5_indirect_42: Indirect call with computed index (dynamic)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 4 funcref)
  (elem (i32.const 0) $app_fn1)
  (elem (i32.const 2) $app_fn2)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $app_fn2 (export "app_fn2"))
  
  (func $app_fn1 (export "app_fn1"))
  
  (func $app_caller (export "app_caller")
    i32.const 1 i32.const 1 i32.add call_indirect (type $void_void)))
