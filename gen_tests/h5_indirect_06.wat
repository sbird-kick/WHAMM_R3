;; h5_indirect_06: Multiple types on same table - void and i32 param
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (type $i32_void (func (param i32)))
  (table 4 funcref)
  (elem (i32.const 0) $r3_h1 $r3_h2)
  
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  
  (func $r3_h1 (type $void_void))
  (func $r3_h2 (type $i32_void)
    local.get 0 drop)
  
  (func $app_work (export "app_work")
    i32.const 0 call_indirect (type $void_void)
    i32.const 5 i32.const 1 call_indirect (type $i32_void)))
