;; h5_indirect_03: Indirect call with i32 param (r3 host)
(module
  (memory (export "memory") 1)
  (type $i32_void (func (param i32)))
  (table 3 funcref)
  (elem (i32.const 0) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $i32_void)
    local.get 0 drop)
  
  (func $app_caller (export "app_caller")
    i32.const 42 i32.const 0 call_indirect (type $i32_void)))
