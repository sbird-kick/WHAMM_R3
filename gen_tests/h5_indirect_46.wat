;; h5_indirect_46: Indirect call with i32i64 params (no return)
(module
  (memory (export "memory") 1)
  (type $i32i64_void (func (param i32 i64)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_use_both)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_use_both (type $i32i64_void)
    local.get 0 drop local.get 1 drop)
  
  (func $app_caller (export "app_caller")
    i32.const 7 i64.const 0x123 i32.const 0 call_indirect (type $i32i64_void)))
