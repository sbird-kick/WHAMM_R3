;; h5_indirect_04: Indirect call with i32 return (app function)
(module
  (memory (export "memory") 1)
  (type $void_i32 (func (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $app_get_value)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 0 call_indirect (type $void_i32) drop)
  
  (func $app_get_value (export "app_get_value") (result i32)
    i32.const 99))
