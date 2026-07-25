;; h5_indirect_26: Multiple params and return (i32, i32 -> i32)
(module
  (memory (export "memory") 1)
  (type $i32i32_i32 (func (param i32 i32) (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_add)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_add (type $i32i32_i32)
    local.get 0 local.get 1 i32.add)
  
  (func $app_caller (export "app_caller")
    i32.const 3 i32.const 4 i32.const 0 call_indirect (type $i32i32_i32) drop))
