;; h5_indirect_09: Return i64 from indirect call to r3
(module
  (memory (export "memory") 1)
  (type $void_i64 (func (result i64)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_get_i64)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_get_i64 (type $void_i64)
    i64.const 777)
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_i64) drop))
