;; h5_indirect_44: Indirect calls in sequence to same index (repeated)
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
    i32.const 1 i32.const 0 call_indirect (type $i32_void)
    i32.const 2 i32.const 0 call_indirect (type $i32_void)
    i32.const 3 i32.const 0 call_indirect (type $i32_void)))
