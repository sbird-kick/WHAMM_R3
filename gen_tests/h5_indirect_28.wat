;; h5_indirect_28: Indirect with conditional (if/else branch taken)
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 3 funcref)
  (elem (i32.const 0) $app_path_a $app_path_b)
  
  (func $r3_main (export "_start") (export "main")
    i32.const 1 call $app_caller)
  
  (func $app_path_b (export "app_path_b"))
  
  (func $app_path_a (export "app_path_a")
    i32.const 1 call_indirect (type $void_void))
  
  (func $app_caller (export "app_caller") (param i32)
    local.get 0
    if
      i32.const 0 call_indirect (type $void_void)
    else
      i32.const 1 call_indirect (type $void_void)
    end))
