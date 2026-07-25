;; h5_indirect_27: Param in indirect call used by app code
(module
  (memory (export "memory") 1)
  (type $i32_void (func (param i32)))
  (table 3 funcref)
  (elem (i32.const 2) $r3_use_param)
  
  (func $r3_main (export "_start") (export "main")
    call $app_call)
  
  (func $r3_use_param (type $i32_void)
    local.get 0 drop)
  
  (func $app_call (export "app_call")
    i32.const 55 i32.const 2 call_indirect (type $i32_void)))
