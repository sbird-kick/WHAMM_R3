;; h5_indirect_14: Three type signatures on same table
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (type $i32_void (func (param i32)))
  (type $void_i32 (func (result i32)))
  (table 5 funcref)
  (elem (i32.const 0) $r3_h1 $r3_h2 $r3_h3)
  
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  
  (func $r3_h1 (type $void_void))
  (func $r3_h2 (type $i32_void)
    local.get 0 drop)
  (func $r3_h3 (type $void_i32)
    i32.const 55)
  
  (func $app_work (export "app_work")
    i32.const 0 call_indirect (type $void_void)
    i32.const 7 i32.const 1 call_indirect (type $i32_void)
    i32.const 2 call_indirect (type $void_i32) drop))
