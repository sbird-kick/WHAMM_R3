;; h5_indirect_41: Indirect call returning multiple values (multi-value return)
(module
  (memory (export "memory") 1)
  (type $void_i32i32 (func (result i32 i32)))
  (table 2 funcref)
  (elem (i32.const 0) $app_pair)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_i32i32) drop drop)
  
  (func $app_pair (export "app_pair") (result i32 i32)
    i32.const 42
    i32.const 99))
