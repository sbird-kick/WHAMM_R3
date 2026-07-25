;; h5_indirect_22: Indirect call with local variable manipulation
(module
  (memory (export "memory") 1)
  (type $i32_i32 (func (param i32) (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_square)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_square (type $i32_i32)
    local.get 0
    local.get 0
    i32.mul)
  
  (func $app_caller (export "app_caller")
    i32.const 7 i32.const 0 call_indirect (type $i32_i32) drop))
