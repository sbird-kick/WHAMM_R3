;; h5_indirect_49: Indirect call with i64 param to r3
(module
  (memory (export "memory") 1)
  (type $i64_void (func (param i64)))
  (table 3 funcref)
  (elem (i32.const 2) $r3_accept_i64)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_accept_i64 (type $i64_void)
    local.get 0 drop)
  
  (func $app_caller (export "app_caller")
    i64.const 0x123456789ABCDEF i32.const 2 call_indirect (type $i64_void)))
