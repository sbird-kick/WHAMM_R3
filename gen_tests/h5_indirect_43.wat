;; h5_indirect_43: Indirect to r3 with void-to-i64 return
(module
  (memory (export "memory") 1)
  (type $void_i64 (func (result i64)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_make_i64)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_make_i64 (type $void_i64)
    i64.const 0xDEADBEEF)
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_i64) drop))
