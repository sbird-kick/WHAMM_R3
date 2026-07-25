;; h5_indirect_05: Indirect call with i32 param and return (r3)
(module
  (memory (export "memory") 1)
  (type $i32_i32 (func (param i32) (result i32)))
  (table 3 funcref)
  (elem (i32.const 1) $r3_double)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_double (param i32) (result i32)
    local.get 0 i32.const 2 i32.mul)
  
  (func $app_caller (export "app_caller")
    i32.const 5 i32.const 1 call_indirect (type $i32_i32) drop))
