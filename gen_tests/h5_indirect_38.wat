;; h5_indirect_38: Indirect call with memory store and load
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_set_mem)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_set_mem (type $void_void)
    i32.const 0 i32.const 0xDEAD i32.store)
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_void)
    i32.const 0 i32.load drop))
