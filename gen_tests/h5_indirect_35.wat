;; h5_indirect_35: Indirect to r3 with i32 param and return
(module
  (memory (export "memory") 1)
  (type $i32_i32 (func (param i32) (result i32)))
  (table 3 funcref)
  (elem (i32.const 1) $r3_fn)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_fn (type $i32_i32)
    local.get 0 i32.const 10 i32.add)
  
  (func $app_caller (export "app_caller")
    i32.const 5 i32.const 1 call_indirect (type $i32_i32) drop))
