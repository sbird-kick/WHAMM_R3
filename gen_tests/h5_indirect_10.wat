;; h5_indirect_10: i64 param to indirect r3 call
(module
  (memory (export "memory") 1)
  (type $i64_void (func (param i64)))
  (table 3 funcref)
  (elem (i32.const 1) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $i64_void)
    local.get 0 drop)
  
  (func $app_caller (export "app_caller")
    i64.const 0x123456789 i32.const 1 call_indirect (type $i64_void)))
