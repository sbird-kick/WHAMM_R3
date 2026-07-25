;; h5_indirect_34: Indirect call with i64 both param and result
(module
  (memory (export "memory") 1)
  (type $i64_i64 (func (param i64) (result i64)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_negate)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_negate (type $i64_i64)
    local.get 0 i64.const -1 i64.mul)
  
  (func $app_caller (export "app_caller")
    i64.const 123 i32.const 0 call_indirect (type $i64_i64) drop))
