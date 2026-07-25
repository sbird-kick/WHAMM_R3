;; h5_indirect_11: Indirect call to r3 with both i32 param and return
(module
  (memory (export "memory") 1)
  (type $i32_i32 (func (param i32) (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_inc)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_inc (type $i32_i32)
    local.get 0 i32.const 1 i32.add)
  
  (func $app_caller (export "app_caller")
    i32.const 10 i32.const 0 call_indirect (type $i32_i32) drop))
