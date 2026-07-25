;; h5_indirect_40: Indirect with three-param function
(module
  (memory (export "memory") 1)
  (type $i32i32i32_void (func (param i32 i32 i32)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_consume)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_consume (type $i32i32i32_void)
    local.get 0 drop local.get 1 drop local.get 2 drop)
  
  (func $app_caller (export "app_caller")
    i32.const 1 i32.const 2 i32.const 3 i32.const 0 call_indirect (type $i32i32i32_void)))
