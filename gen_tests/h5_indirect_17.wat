;; h5_indirect_17: Complex param/return: i32, i64 combo
(module
  (memory (export "memory") 1)
  (type $i32i64_i64 (func (param i32 i64) (result i64)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host (type $i32i64_i64)
    local.get 1)
  
  (func $app_caller (export "app_caller")
    i32.const 1 i64.const 888 i32.const 0 call_indirect (type $i32i64_i64) drop))
