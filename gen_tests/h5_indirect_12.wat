;; h5_indirect_12: Indirect with memory load after call
(module
  (memory (export "memory") 1)
  (data (i32.const 0) "ABCD")
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_setup)
  
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  
  (func $r3_setup (type $void_void)
    i32.const 0 i32.const 0xFF i32.store)
  
  (func $app_work (export "app_work")
    i32.const 0 call_indirect (type $void_void)
    i32.const 0 i32.load drop))
